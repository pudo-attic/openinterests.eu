import logging
from pprint import pprint
from hashlib import sha1

from grano.service import Loader

from sources.fts.util import engine, fts_entry


log = logging.getLogger('sources.fts.load')
FTS_URL = 'http://ec.europa.eu/budget/fts/index_en.htm'


def load(loader, row):
	dept = loader.make_entity(['public_body'])
	dept.set('name', row.pop('responsible_department'))
	dept.save()

	bfry = loader.make_entity(['organisation', 'address', 'geolocated'])
	bfry.set('name', row.pop('beneficiary'))
	bfry.set('abbreviation', row.pop('alias'))

	osm_url = 'http://open.mapquestapi.com/nominatim'
	bfry.set('lon', row.pop('lon'), source_url=osm_url)
	bfry.set('lat', row.pop('lat'), source_url=osm_url)
	bfry.set('nuts1', row.pop('nuts1'), source_url=osm_url)
	bfry.set('nuts1_label', row.pop('nuts1_label'), source_url=osm_url)
	bfry.set('nuts1', row.pop('nuts2'), source_url=osm_url)
	bfry.set('nuts1_label', row.pop('nuts2_label'), source_url=osm_url)
	bfry.set('nuts1', row.pop('nuts3'), source_url=osm_url)
	bfry.set('nuts1_label', row.pop('nuts3_label'), source_url=osm_url)

	bfry.set('address', row.pop('address'))
	bfry.set('city', row.pop('city'))
	bfry.set('country', row.pop('country'))
	bfry.set('postcode', row.pop('postcode'))
	bfry.save()

	log.info("loading: %s", row.get('grant_subject'))

	tx = loader.make_relation('fts_committment', dept, bfry)
	tx_id = '%s // %s' % (row['date'], row['source_id'])
	tx.unique('transaction_id')
	tx.set('transaction_id', sha1(tx_id).hexdigest())
	tx.set('action_type', row.pop('action_type'))
	tx.set('amount', row.pop('amount'))
	tx.set('article', row.pop('article'))
	tx.set('budget_code', row.pop('budget_code'))
	tx.set('budget_item', row.pop('budget_item'))
	tx.set('chapter', row.pop('chapter'))
	tx.set('cofinancing_rate', row.pop('cofinancing_rate'))
	tx.set('cofinancing_rate_pct', row.pop('cofinancing_rate_pct'))
	tx.set('coordinator', row.pop('coordinator'))
	tx.set('date', row.pop('date'))
	tx.set('grant_subject', row.pop('grant_subject'))
	tx.set('item', row.pop('item'))
	tx.set('position_key', row.pop('position_key'))
	tx.set('title', row.pop('title'))
	tx.set('total', row.pop('total'))
	tx.save()

	loader.persist()
	#pprint(dict(row))

def load_all():
	loader = Loader(source_url=FTS_URL)
	for row in fts_entry:
		load(loader, row)


if __name__ == '__main__':
	load_all()
