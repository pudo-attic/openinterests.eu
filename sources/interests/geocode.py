import logging
import requests

from sources.util import geocode
from sources.interests.util import reg_representative


log = logging.getLogger(__name__)
KEYS = ['contact_town', 'contact_street', 'contact_country', 'contact_post_code']


def transform():
    log.info("Geo-coding representatives...")
    for row in list(reg_representative.distinct('contact_lon', *KEYS)):
        if row.get('contact_lon'):
            continue
        geo = geocode(city=row.get('contact_town'), street=row.get('contact_street'),
            country=row.get('contact_country'), postalcode=row.get('contact_post_code'))
        if geo is not None:
            row['contact_geoname'] = geo.get('display_name')
            row['contact_lon'] = geo.get('lon')
            row['contact_lat'] = geo.get('lat')
            row['contact_nuts1'] = geo.get('nuts1')
            row['contact_nuts1_label'] = geo.get('nuts1_label')
            row['contact_nuts2'] = geo.get('nuts2')
            row['contact_nuts2_label'] = geo.get('nuts2_label')
            row['contact_nuts3'] = geo.get('nuts3')
            row['contact_nuts3_label'] = geo.get('nuts3_label')
            reg_representative.upsert(row, KEYS)


if __name__ == '__main__':
    transform()
