import logging
import requests
import csv

import shapegeocode

from sources.util.db import engine
from sources.util.data import reference_data_path

log = logging.getLogger(__name__)
URL = "http://open.mapquestapi.com/nominatim/v1/search.php"
RES = {}
geocode_cache = engine['shd_geocode']

def load_region_hierarchy():
    with open(reference_data_path('NUTS_2006.csv'), 'rb') as fh:
        data = {}
        for row in csv.DictReader(fh):
            data[row['CODE']] = dict([(k, v.decode('utf-8')) \
                for k, v in row.items()])
        return data


def geocode(city=None, street=None, country=None, postalcode=None, countrycodes=None):
    query = {
            'city': city,
            'street': street,
            'country': country,
            'postalcode': postalcode,
            'countrycodes': countrycodes
            }

    for k, v in query.items():
        if v is None:
            del query[k]

    res = geocode_cache.find_one(**query)
    if res is None:
        q = {'format': 'json', 'limit': 1}
        q.update(query)
        try:
            #print query
            response = requests.get(URL, params=q)
            json = response.json()
            #print json
            if json and len(json):
                geo = json[0]
                log.info("%s", geo.get('display_name'))
                res = {
                    'display_name': geo.get('display_name'),
                    'lon': geo.get('lon'),
                    'lat': geo.get('lat')
                }
                res.update(query)
                res.update(resolve_nuts(res))
                geocode_cache.insert(res, query.keys())
            else:
                geocode_cache.insert(query, query.keys())
        except Exception, e:
            log.exception(e)

    return res


def resolve_nuts(row):
    if not 'regions' in RES:
        RES['regions'] = load_region_hierarchy()
    if not 'geocoder' in RES:
        RES['geocoder'] = shapegeocode.geocoder(
            reference_data_path('nuts2-shapefile/data/NUTS_RG_10M_2006.shp'),
            filter=lambda r: r['STAT_LEVL_'] == 3)

    try:
        data = RES['geocoder'].geocode(float(row['lat']), float(row['lon']))
        if data is None:
            return {}
        nuts3_code = data.get('NUTS_ID')
        nuts3 = RES['regions'].get(nuts3_code, {})
        nuts2 = RES['regions'].get(nuts3_code[:4], {})
        nuts1 = RES['regions'].get(nuts3_code[:3], {})
        return {
            'nuts3': nuts3_code,
            'nuts3_label': nuts3.get('LABEL'),
            'nuts2': nuts3_code[:4],
            'nuts2_label': nuts2.get('LABEL'),
            'nuts1': nuts3_code[:3],
            'nuts1_label': nuts1.get('LABEL'),
            }
    except Exception, e:
        log.exception(e)
        return {}  