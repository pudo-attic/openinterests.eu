import logging
import requests
from lxml import html
from datetime import datetime

from sources.util.cache import ensure_path


log = logging.getLogger(__name__)
URL = 'https://webgate.ec.europa.eu/publications/ted-export/%s/'
AUTH = ('ted-export', 'R2-dHqZ3')


def make_iso_list():
    with open(ensure_path('ted/iso_list.txt'), 'w') as fh:
        for year in range(2010, datetime.utcnow().year+1):
            log.info("Listing monthly TED ISOs for %s", year)
            res = requests.get(URL % year, auth=AUTH)
            doc = html.fromstring(res.content)
            urls = [a.get('href') for a in doc.findall('.//a') if 'monthly.iso' in a.get('href')]
            for url in urls:
                url = url.replace('//', '//' + AUTH[0] + ':' + AUTH[1] + '@')
                fh.write(url + '\r\n')


if __name__ == '__main__':
    make_iso_list()
