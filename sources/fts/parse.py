#coding: utf-8
import HTMLParser
import logging
from lxml import etree

from sources.util import walk_path
from sources.fts.util import engine, fts_entry

log = logging.getLogger('sources.fts.parse')
NUMCHAR = "0123456789-."

def to_float(num):
    try:
        num = num.replace('.', '').replace(',', '.')
        return float(''.join([n for n in num if n in NUMCHAR]))
    except:
        "NaN"

def convert_commitment(base, commitment):
    common = {}
    common['date'] = commitment.findtext('year')
    common['total'] = to_float(commitment.findtext('amount'))
    common['cofinancing_rate'] = commitment.findtext('cofinancing_rate')
    common['cofinancing_rate_pct'] = to_float(common['cofinancing_rate'])
    common['position_key'] = commitment.findtext('position_key')
    common['grant_subject'] = commitment.findtext('grant_subject')
    common['responsible_department'] = commitment.findtext('responsible_department')
    common['action_type'] = commitment.findtext('actiontype')
    budget_line = commitment.findtext('budget_line')

    name, code = budget_line.rsplit('(', 1)
    code = code.replace(')', '').replace('"', '').strip()
    common['budget_item'] = name.strip()
    common['budget_code'] = code

    parts = code.split(".")
    common['title'] = parts[0]
    common['chapter'] = '.'.join(parts[:2])
    common['article'] = '.'.join(parts[:3])
    if len(parts) == 4:
        common['item'] = '.'.join(parts[:4])

    for beneficiary in commitment.findall('.//beneficiary'):
        row = common.copy()
        row['beneficiary'] = beneficiary.findtext('name')
        if '*' in row['beneficiary']:
            row['beneficiary'], row['alias'] = row['beneficiary'].split('*', 1)
        else:
            row['alias'] = row['beneficiary']
        row['address'] = beneficiary.findtext('address')
        row['city'] = beneficiary.findtext('city')
        row['postcode'] = beneficiary.findtext('post_code')
        row['country'] = beneficiary.findtext('country')
        row['geozone'] = beneficiary.findtext('geozone')
        row['coordinator'] = beneficiary.findtext('coordinator')
        detail_amount = beneficiary.findtext('detail_amount')
        if detail_amount is not None and len(detail_amount):
            row['amount'] = to_float(detail_amount)
        else: 
            row['amount'] = row['total']
        if row['amount'] is "NaN":
            row['amount'] = row['total']

        base['source_id'] += 1
        row.update(base)
        log.info('%s - %s', row['grant_subject'], row['beneficiary'])
        fts_entry.upsert(row, ['source_file', 'source_id'])


def convert_file(file_name):
    h = HTMLParser.HTMLParser()
    with open(file_name, 'r') as fh:
        text = fh.read().decode('utf-8')
        text = h.unescape(text).encode('utf-8')
        doc = etree.fromstring(text)
        #engine.begin()
        base = {'source_file': file_name, 'source_id': 0}
        for i, commitment in enumerate(doc.findall('.//commitment')):
            base['source_line'] = commitment.sourceline
            base['source_contract_id'] = i
            convert_commitment(base, commitment)
        #engine.commit()


def load_fts():
    for file_name in walk_path('fts/'):
        convert_file(file_name)

if __name__ == '__main__':
    load_fts()

