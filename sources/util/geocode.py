import logging
import requests

from sources.util.db import engine

log = logging.getLogger(__name__)
URL = "http://open.mapquestapi.com/nominatim/v1/search.php"
geocode_cache = engine['shd_geocode']


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
            print query
            response = requests.get(URL, params=q)
            json = response.json()
            print json
            if json and len(json):
                geo = json[0]
                log.info("%s", geo.get('display_name'))
                res = {
                    'display_name': geo.get('display_name'),
                    'lon': geo.get('lon'),
                    'lat': geo.get('lat')
                }
                res.update(query)
                geocode_cache.insert(res, query.keys())
            else:
                geocode_cache.insert(query, query.keys())
        except Exception, e:
            log.exception(e)

    if res is not None:
        return {
            'lat': res.get('lat'),
            'lon': res.get('lon'),
            'display_name': res.get('display_name')
            }
