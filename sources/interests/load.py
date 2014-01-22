import logging
from pprint import pprint
from hashlib import sha1

from grano.service import Loader

from sources.interests.util import engine
from sources.interests.util import reg_person, reg_financial_data
from sources.interests.util import reg_financial_data_custom_source
from sources.interests.util import reg_financial_data_turnover
from sources.interests.util import reg_representative, reg_organisation


log = logging.getLogger('sources.interests.load')
EXPERTS_URL = 'http://ec.europa.eu/transparency/regexpert/index.cfm?do=transparency.showList'


def load(loader, row):
    row.pop('id')
    
    etl_id = row.pop('etl_id')
    rep_id = row.pop('identification_code')

    log.info("Loading: %s, %s", rep_id, row.get('name'))
    rep = loader.make_entity(['address', 'web', 'geolocated', 'organisation', 'representative'])
    rep.set('name', row.pop('name'))
    rep.set('abbreviation', row.pop('acronym'))
    rep.set('reg_identifier', rep_id)

    rep.set('url', row.pop('web_site_url'))
    rep.set('address', row.pop('contact_street'))
    rep.set('address_ctd', row.pop('contact_number'))
    rep.set('postcode', row.pop('contact_post_code'))
    rep.set('city', row.pop('contact_town'))
    rep.set('country', row.pop('contact_country'))
    rep.set('address_more', row.pop('contact_more'))
    rep.set('phone', '+' + (row.pop('contact_indic_phone') or '') + ' ' + (row.pop('contact_phone') or ''))
    rep.set('fax', '+' + (row.pop('contact_indic_fax') or '') + ' ' + (row.pop('contact_fax') or ''))

    rep.set('lon', row.pop('contact_lon', None))
    rep.set('lat', row.pop('contact_lat', None))
    rep.set('nuts1', row.pop('contact_nuts1', None))
    rep.set('nuts1_label', row.pop('contact_nuts1_label', None))
    rep.set('nuts2', row.pop('contact_nuts2', None))
    rep.set('nuts2_label', row.pop('contact_nuts2_label', None))
    rep.set('nuts3', row.pop('contact_nuts3', None))
    rep.set('nuts3_label', row.pop('contact_nuts3_label', None))

    rep.set('reg_legal_status', row.pop('legal_status'))
    rep.set('reg_entry_status', row.pop('status'))
    rep.set('reg_activities', row.pop('activities'))
    rep.set('reg_goals', row.pop('goals'))
    rep.set('reg_networking', row.pop('networking'))
    rep.set('registration_date', row.pop('registration_date'))
    rep.set('main_category', row.pop('main_category'))
    rep.set('sub_category', row.pop('sub_category'))

    # TODO: 
    # 'code_of_conduct': u"European Commission's code of conduct for interest representative",
    # u'contact_geoname': None,
    # u'last_update_date': datetime.datetime(2013, 4, 22, 1, 52, 15, 313000),
    # u'members': u'5.0',
    # u'number_of_natural_persons': u'130000',
    # u'number_of_organisations': None,
    # u'original_name': u'Arcigay',
    
    # people
    for p in reg_person.find(representative_etl_id=etl_id):
        per = loader.make_entity(['person'])
        per.set('name', p.pop('name'))
        per.set('title', p.pop('title'))
        per.set('last_name', p.pop('last_name'))
        per.set('first_name', p.pop('first_name'))
        per.save()

        role = loader.make_relation('reg_role', per, rep)
        role.set('role', p.pop('role'))
        role.set('position', p.pop('position'))
        role.save()

        #pprint(dict(p))

    # organisations
    for o in reg_organisation.find(representative_etl_id=etl_id):
        org = loader.make_entity(['organisation'])
        org.set('name', o.pop('name'))
        org.set('number_of_members', o.pop('number_of_members'))
        org.save()

        role = loader.make_relation('reg_membership', org, rep)
        role.save()

    # turnover 
    for fdt in reg_financial_data_turnover.find(representative_etl_id=etl_id):
        org = loader.make_entity(['organisation'])
        org.set('name', fdt.pop('name'))
        org.save()        

        to = loader.make_relation('reg_turnover', org, rep)
        to.set('turnover_min', fdt.pop('min'))
        to.set('turnover_max', fdt.pop('max'))
        to.save()
    
    #pprint(dict(row))
    loader.persist()


def load_all():
    loader = Loader()
    for row in reg_representative:
        load(loader, row)


if __name__ == '__main__':
    load_all()
