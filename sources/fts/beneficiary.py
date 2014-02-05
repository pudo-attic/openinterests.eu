import logging
import requests
import json

import util
import sqlaload as sl

logging.basicConfig(level=logging.DEBUG)
log = logging.getLogger('beneficiary')
session = requests.session()

SCORE_CUTOFF = 70


def lookup(val, country_code, engine):
    table = sl.get_table(engine, 'supplier')
    data = sl.find_one(engine, table, name=val)
    if data is not None:
        return data['canonical'], data['uri'], data['score']
    try:
        url = 'http://opencorporates.com/reconcile/%s' % country_code.lower()
        query = json.dumps({'query': val, 'limit': 1})
        res = session.get(url,
                params={'query': query})
        data = {'name': val, 'canonical': None, 'uri': None, 'score': 0}
        if res.ok and len(res.json().get('result')):
            r = res.json().get('result').pop()
            data['canonical'] = r['name']
            data['uri'] = r['uri']
            data['score'] = r['score']
        log.info('OpenCorporates Lookup: %s -> %s', val, data['canonical'])
        sl.upsert(engine, table, data, unique=['name'])
        return data['canonical'], data['uri'], data['score']
    except Exception, ex:
        log.exception(ex)
        return None, None, None


def merge():
    engine = util.make_engine()
    table = sl.get_table(engine, 'fts')
    for row in sl.distinct(engine, table, 'beneficiary', 'country_code'):
        canonical, uri, score = lookup(row.get('beneficiary'), row.get('country_code'), engine)
        row['beneficiary_canonical'] = canonical
        row['beneficiary_uri'] = uri
        row['beneficiary_score'] = score
        sl.upsert(engine, table, row, ['beneficiary', 'country'])


if __name__ == '__main__':
    merge()
