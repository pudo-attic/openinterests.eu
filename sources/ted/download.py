import requests
import logging
import os
from lxml import html
from pprint import pprint
import tarfile

from sources.util.cache import ensure_path


log = logging.getLogger(__name__)
ECAS_USER, ECAS_PASSWORD = os.environ.get("ECAS_USER"), os.environ.get("ECAS_PASSWORD")


def make_ecas_session():
    session = requests.Session()
    data = {'lgid': 'en', 'action': 'gp'}
    res = session.get('http://ted.europa.eu/TED/browse/browseByBO.do')
    res = session.post('http://ted.europa.eu/TED/main/HomePage.do?pid=secured',
                       data=data, cookies={'lg': 'en'},
                       allow_redirects=True)
    a = html.fromstring(res.content).find('.//div[@id="main_domain"]/a[@title="External"]')
    res = session.get(a.get('href'))
    form = html.fromstring(res.content).find('.//form[@id="loginForm"]')
    data = dict([(i.get('name'), i.get('value')) for i in form.findall('.//input')])
    data['username'] = ECAS_USER
    data['password'] = ECAS_PASSWORD
    data['selfHost'] = 'webgate.ec.europa.eu'
    data['timeZone'] = 'GMT-04:00'
    res = session.post(form.get('action'), data=data,
                       allow_redirects=True)
    doc = html.fromstring(res.content)
    #print res.content
    form = doc.find('.//form[@id="showAccountDetailsForm"]')
    #print form
    data = dict([(i.get('name'), i.get('value')) for i in form.findall('.//input')])
    res = session.post(form.get('action'), data=data, allow_redirects=True)
    doc = html.fromstring(res.content)
    link = filter(lambda a: 'redirecting-to' in a.get('href', ''), doc.findall('.//a'))
    res = session.get(link.pop().get('href'))
    log.info("ECAS Session created.")
    return session


def download_by_id(session, bulk_id):
    dest_path = ensure_path('ted/archives/%s.tgz' % bulk_id)
    log.info("Loading: %s" % dest_path)
    if os.path.exists(dest_path):
        log.info("Skip: exists")
        return dest_path
    url = "http://ted.europa.eu/TED/misc/bulkDownloadExport.do?dlTedExportojsId=%s"
    url = url % bulk_id
    data = {'action': 'dlTedExport'}
    res = session.post(url, data=data, allow_redirects=True)
    if 'html' in res.headers.get('content-type'):
        return False
    with open(dest_path, 'wb') as fh:
        fh.write(res.content)
    log.info("Downloaded: %s" % dest_path)
    return dest_path
    #pprint(dict(res.headers))


def extract_data(path):
    prefix = ensure_path('ted/xml/')
    tf = tarfile.open(path, "r:gz")
    log.info("Extracing %s", path)
    for member in tf.getmembers():
        mpath = os.path.join(prefix, member.name)
        if not os.path.exists(mpath):
            print 'foo', member
            tf.extract(member, path=prefix)


def download_latest(session):
    res = session.get('http://ted.europa.eu/TED/misc/bulkDownloadExport.do')
    doc = html.fromstring(res.content)
    for inp in doc.findall('.//input'):
        name = inp.get('name', '')
        if 'dlTedExportojsId' in name:
            bulk_id = inp.get('value')
            file_path = download_by_id(session, bulk_id)
            if not file_path:
                continue
            extract_data(file_path)


if __name__ == '__main__':
    session = make_ecas_session()
    download_latest(session)
