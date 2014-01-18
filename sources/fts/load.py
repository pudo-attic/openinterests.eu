import logging
from pprint import pprint

from grano.service import Loader

from sources.fts.util import engine, fts_entry


log = logging.getLogger(__name__)
FTS_URL = 'http://ec.europa.eu/budget/fts/index_en.htm'


def load(loader, row):
	dept = loader.make_entity(['public_body'])
	dept.set('name', row.pop('responsible_department'))

	bfry = loader.make_entity(['organisation', 'address', 'geolocated'])
	bfry.set('name', row.pop('beneficiary'))
	bfry.set('acronym', row.pop('alias'))

	bfry.set('lon', row.pop('lon'))
	bfry.set('lat', row.pop('lat'))
	bfry.set('nuts1', row.pop('nuts1'))
	bfry.set('nuts1_label', row.pop('nuts1_label'))
	bfry.set('nuts1', row.pop('nuts2'))
	bfry.set('nuts1_label', row.pop('nuts2_label'))
	bfry.set('nuts1', row.pop('nuts3'))
	bfry.set('nuts1_label', row.pop('nuts3_label'))

	bfry.set('street', row.pop('address'))
	bfry.set('city', row.pop('city'))
	bfry.set('country', row.pop('country'))
	bfry.set('postcode', row.pop('postcode'))

	pprint(dict(row))


def load_all():
	loader = Loader(source_url=FTS_URL)
	for row in fts_entry:
		load(loader, row)


if __name__ == '__main__':
	load_all()