import requests
import logging
from datetime import datetime
from sources.util import fetch_data

log = logging.getLogger('sources.fts.download')
BASE_URL = 'http://ec.europa.eu/budget/remote/fts/dl/export_%s_en.xml'


def download():
	for year in range(2007, datetime.now().year):
		log.info("Downloading FTS for %s", year)
		url = BASE_URL % year
		fetch_data(url, 'fts/export_%s.xml' % year)


if __name__ == '__main__':
	download()