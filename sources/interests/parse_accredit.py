
import logging
from lxml import etree
from pprint import pprint

from sources.util import fetch_data
from sources.interests.util import reg_person, reg_representative
from sources.interests.util import shortdateconv as dateconv

log = logging.getLogger(__name__)

URL = "http://ec.europa.eu/transparencyregister/public/consultation/statistics.do?action=getLobbyistsXml&fileType=ACCREDITED_PERSONS"
_NS = "http://ec.europa.eu/transparencyregister/accreditedPerson/V1"
NS = '{%s}' % _NS


def parse(fh):
    doc = etree.parse(fh)
    for ap_el in doc.findall('//' + NS + 'accreditedPerson'):
        ap = {
            'org_identification_code': ap_el.findtext(NS + 'orgIdentificationCode'),
            'number_of_ir': ap_el.findtext(NS + 'numberOfIR'),
            'org_name': ap_el.findtext(NS + 'orgName'),
            'title': ap_el.findtext(NS + 'title'),
            'first_name': ap_el.findtext(NS + 'firstName'),
            'last_name': ap_el.findtext(NS + 'lastName'),
            'start_date': dateconv(ap_el.findtext(NS + 'accreditationStartDate')),
            'end_date': dateconv(ap_el.findtext(NS + 'accreditationEndDate')),
            }
        yield ap


def save(person):
    orgs = list(reg_representative.find(identification_code=person['org_identification_code']))
    if len(orgs):
        org = max(orgs, key=lambda o: o['last_update_date'])
        person['representative_etl_id'] = org['etl_id']
        person['role'] = 'accredited'
        name = '%s %s %s' % (person['title'] or '',
                             person['first_name'] or '',
                             person['last_name'] or '')
        person['name'] = name.strip()
        log.debug("Accreditation: %s", name)
        reg_person.upsert(person, ['representative_etl_id', 'role', 'name'])
    else:
        log.warn("Cannot associate with a registered interest: %r", person)


def extract_data(fh):
    log.info("Extracting accredditation data...")
    for i, ap in enumerate(parse(fh)):
        save(ap)
        if i % 100 == 0:
            log.info("Extracted: %s...", i)


def extract():
    path = fetch_data(URL, 'interests/accredditation.xml', max_age=84600*7)
    with open(path, 'r') as fh:
        extract_data(fh)


if __name__ == '__main__':
    extract()

