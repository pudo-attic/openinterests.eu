import logging
from pprint import pprint
from hashlib import sha1

from sources.util.loader import make_loader
from sources.experts.util import engine
from sources.experts.util import exp_group, exp_sub_group, exp_group_type
from sources.experts.util import exp_group_task, exp_group_associated_dg
from sources.experts.util import exp_group_policy_area, exp_group_note
from sources.experts.util import exp_group_member


log = logging.getLogger('sources.experts.load')
EXPERTS_URL = 'http://ec.europa.eu/transparency/regexpert/index.cfm?do=transparency.showList'
URL = 'http://ec.europa.eu/transparency/regexpert/index.cfm?do=groupDetail.groupDetail&groupID=%s'

def load(loader, row):
    grp_id = row.pop('group_id')
    url_id = int(grp_id[1:])
    source_url = URL % url_id

    log.info("Loading: %s, %s", grp_id, row.get('name'))
    grp = loader.make_entity(['public_body', 'organisation', 'expert_group'],
        source_url=source_url)
    grp.set('name', row.pop('name'))
    grp.set('abbreviation', row.pop('abbreviation'))
    grp.set('exp_identifier', grp_id)
    grp.set('exp_scope', row.pop('scope'))
    grp.set('exp_mission', row.pop('mission'))
    grp.set('exp_status', row.pop('status'))
    grp.set('exp_active_since', row.pop('active_since'))
    grp.save()

    lead_dg = loader.make_entity(['public_body'], source_url=source_url)
    lead_dg.set('name', row.pop('lead_dg'))
    lead_dg.save()

    rel = loader.make_relation('expert_group_associated', lead_dg, grp,
        source_url=source_url)
    rel.set('role', 'lead')
    rel.save()

    for d in exp_group_associated_dg.find(group_id=grp_id):
        dg = loader.make_entity(['public_body'], source_url=source_url)
        dg.set('name', d.pop('dg'))
        dg.save()

        rel = loader.make_relation('expert_group_associated', dg, grp,
            source_url=source_url)
        rel.set('role', 'associated')
        rel.save()

    #SUB_GROUPS = {}
    # TODO: subgroups later.
    for m in exp_group_member.find(group_id=grp_id):
        schemata = []
        if m['member_type'] == 'National administrations':
            schemata.append('public_body')
            if m['public_authorities']:
                m['name'] = '%(public_authorities)s (%(country)s)' % m
            else:
                m['name'] = m['country']
        elif m['member_type'] == 'Organisation':
            schemata.append('organisation')
        else:
            schemata.append('person')

        if m.get('country_common'):
            schemata.append('address')
            
        mem = loader.make_entity(schemata, source_url=source_url)
        mem.set('name', m.pop('name'))
        mem.set('country', m.get('country_common'))
        mem.set('country_code', m.get('country_code'))
        mem.save()

        rel = loader.make_relation('expert_group_member', mem, grp,
            source_url=source_url)
        rel.set('exp_status', m.pop('status'))
        rel.set('exp_type', m.pop('member_type'))
        rel.save()
        #pprint(dict(m))

    loader.persist()
    #pprint(dict(row))


def load_all():
    loader = make_loader(source_url=EXPERTS_URL)
    for row in exp_group:
        load(loader, row)


if __name__ == '__main__':
    load_all()
