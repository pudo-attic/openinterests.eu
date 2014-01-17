import logging
import requests

from sources.util import geocode
from sources.fts.util import engine, fts_entry


log = logging.getLogger(__name__)
KEYS = ['country', 'address', 'city', 'postcode']


def transform():
    log.info("Geo-coding FTS recipients...")
    for row in list(fts_entry.distinct(*KEYS)):
        #print row
        #if row.get('lon'):
        #    continue
        geo = geocode(city=row.get('city'), street=row.get('address'),
            country=row.get('country'), postalcode=row.get('postcode'))
        if geo is not None:
            #row['geoname'] = geo.get('display_name')
            row['lon'] = geo.get('lon')
            row['lat'] = geo.get('lat')
            row['nuts1'] = geo.get('nuts1')
            row['nuts1_label'] = geo.get('nuts1_label')
            row['nuts2'] = geo.get('nuts2')
            row['nuts2_label'] = geo.get('nuts2_label')
            row['nuts3'] = geo.get('nuts3')
            row['nuts3_label'] = geo.get('nuts3_label')
            fts_entry.upsert(row, KEYS)


if __name__ == '__main__':
    transform()
