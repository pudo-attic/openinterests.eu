import dataset
import logging
from lxml import etree
from pprint import pprint
from datetime import datetime

from sources.util import engine, walk_path

log = logging.getLogger(__name__)
NS = '{http://ec.europa.eu/transparency/regexpert/}'


def complex_date(el):
    return datetime(year=int(el.findtext(NS+'year')),
                    month=int(el.findtext(NS+'month')),
                    day=int(el.findtext(NS+'day')))


def text_list(els):
    return [el.text for el in els]


def info_link_obj(el):
    return {
        'info': el.findtext(NS+'info'),
        'link': el.findtext(NS+'link')
        }


def parse_members(members):
    data = []
    for member_type in members.findall(NS+'member_type'):
        base = {'member_type': member_type.findtext(NS+'name')}
        for member in member_type.findall(NS+'member'):
            m = base.copy()
            m.update({
                'name': member.findtext(NS+'name'),
                'country': member.findtext(NS+'country'),
                'status': member.findtext(NS+'status'),
                'type': member.findtext(NS+'type'),
                'public_authorities': member.findtext(NS+'public_authorities//'+NS+'name'),
                'categories': text_list(member.findall(NS+'categories/'+NS+'category')),
                'areas_represented': text_list(member.findall(NS+'areas_countries_represented/'+NS+'area_country_represented'))
                })
            data.append(m)
    return data

def parse_subgroup(sub_group):
    return {
            'name': sub_group.findtext(NS+'name'),
            'members': parse_members(sub_group.find(NS+'members'))
        }

def parse_groups(doc):
    for group in doc.findall('//' + NS + 'group'):
        data = {
            'id': group.findtext(NS + 'id'),
            'name': group.findtext(NS + 'name'),
            'abbreviation': group.findtext(NS + 'abbreviation'),
            'lead_dg': group.findtext(NS + 'lead_dg'),
            'scope': group.findtext(NS + 'scope'),
            'mission': group.findtext(NS + 'mission'),
            'status': group.findtext(NS + 'status'),
            'active_since': complex_date(group.find(NS + 'active_since')),
            'last_updated': complex_date(group.find(NS + 'last_updated')),
            'associated_dgs': text_list(group.findall(NS+'associated_dgs/'+NS+'associated_dg')),
            'members': parse_members(group.find(NS+'group_members/'+NS+'member_types')),
            'types': text_list(group.findall(NS+'types/'+NS+'type')),
            'tasks': text_list(group.findall(NS+'tasks/'+NS+'task')),
            'policy_areas': text_list(group.findall(NS+'policy_areas/'+NS+'policy_area')),
            'sub_groups': [parse_subgroup(g) for g in group.findall(NS+'sub_groups/'+NS+'sub_group')],
            'rules_of_procedures': [info_link_obj(g) for g in group.findall(NS+'additional_information/'+NS+'rules_of_procedures/'+NS+'rules_of_procedure')],
            'selection_procedures': [info_link_obj(g) for g in group.findall(NS+'additional_information/'+NS+'selection_procedures/'+NS+'selection_procedure')],
            'others': [info_link_obj(g) for g in group.findall(NS+'additional_information/'+NS+'others/'+NS+'other')],
            'activity_reports': [info_link_obj(g) for g in group.findall(NS+'additional_information/'+NS+'activity_reports/'+NS+'activity_report')]
            }
        yield data


def store_member(group_id, member, subgroup_name=None):
    # TODO:
    member.pop('areas_represented')
    member.pop('categories')
    member.update({'group_id': group_id, 'subgroup_name': subgroup_name})
    engine['exp_group_member'].upsert(member,
        ['group_id', 'subgroup_name', 'member_type', 'name', 'country'])


def store_notes(group_id, note, category):
    note.update({'group_id': group_id, 'category': category})
    engine['exp_group_note'].upsert(note,
        ['group_id', 'category', 'link', 'info'])


def store_group(group):
    group_id = group.pop('id')
    for type_name in group.pop('types'):
        engine['exp_group_type'].upsert(
            {'type': type_name, 'group_id': group_id},
            ['type', 'group_id'])
    for task_name in group.pop('tasks'):
        engine['exp_group_task'].upsert(
            {'task': task_name, 'group_id': group_id},
            ['task', 'group_id'])
    for dg in group.pop('associated_dgs'):
        engine['exp_group_associated_dg'].upsert(
            {'dg': dg, 'group_id': group_id},
            ['dg', 'group_id'])
    for policy_area in group.pop('policy_areas'):
        engine['exp_group_policy_area'].upsert(
            {'policy_area': policy_area, 'group_id': group_id},
            ['policy_area', 'group_id'])
    for member in group.pop('members'):
        store_member(group_id, member)
    for sub_group in group.pop('sub_groups'):
        engine['exp_sub_group'].upsert(
            {'name': sub_group['name'], 'group_id': group_id},
            ['name', 'group_id'])
        for member in sub_group.pop('members'):
            store_member(group_id, member, sub_group['name'])
    for note in group.pop('rules_of_procedures'):
        store_notes(group_id, note, 'rules_of_procedures')
    for note in group.pop('selection_procedures'):
        store_notes(group_id, note, 'selection_procedures')
    for note in group.pop('activity_reports'):
        store_notes(group_id, note, 'activity_reports')
    for note in group.pop('others'):
        store_notes(group_id, note, 'others')
    group['group_id'] = group_id
    engine['exp_group'].upsert(group, ['group_id'])
    #pprint(group)


def parse_regexp():
    for file_name in walk_path('experts/'):
        with open(file_name, 'rb') as fh:
            doc = etree.parse(fh)
            for group in parse_groups(doc):
                log.info("Importing %s" % group.get('name'))
                store_group(group)


if __name__ == '__main__':
    parse_regexp()