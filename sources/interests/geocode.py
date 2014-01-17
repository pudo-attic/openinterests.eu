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
            reg_representative.upsert(row, KEYS)

if __name__ == '__main__':
    transform()
