import csv
import Levenshtein
from pprint import pprint

import util
import sqlaload as sl

COUNTRIES_URL = 'iso_3166_2_countries.csv'
COUNTRIES_DATA = {}


def read_countries():
    fh = open(COUNTRIES_URL, 'r')
    for row in csv.DictReader(fh):
        key = row.get('eu').strip().encode('ascii', 'ignore')
        COUNTRIES_DATA[key] = \
            dict([(k, r.decode('utf-8')) for (k, r) in \
            row.items()])
    fh.close()


def match(country):
    country = country.strip().encode('ascii', 'ignore')
    return COUNTRIES_DATA.get(country) or {}


def merge():
    read_countries()
    engine = util.make_engine()
    table = sl.get_table(engine, 'fts')
    for row in sl.distinct(engine, table, 'country'):
        country = row.get('country')
        data = match(country)
        row['country_code'] = data.get('iso_3166-1_2')
        row['country_common'] = data.get('common')
        sl.upsert(engine, table, row, ['country'])


if __name__ == '__main__':
    merge()
