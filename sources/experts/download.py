import requests
from lxml import html
import logging
from datetime import datetime
from sources.util import fetch_data

log = logging.getLogger('sources.experts.download')
BASE_URL = 'http://ec.europa.eu/transparency/regexpert/index.cfm?do=transparency.showList'


def download():
	res = requests.get(BASE_URL)
	doc = html.fromstring(res.content)
	for a in doc.findall('.//div[@class="centreBodyContent"]//a'):
		link = a.get('href')
		if not 'openXML' in link:
			continue

		fetch_data(link, 'experts/expert_groups.xml', max_age=84600*7)


if __name__ == '__main__':
	download()