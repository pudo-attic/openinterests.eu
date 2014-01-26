from pprint import pprint
from hashlib import sha1
import logging

from grano.service import Loader

from sources.ted.util import ted_contracts

log = logging.getLogger('sources.ted.load')

# FOR DEBUG ONLY:
def cleanup(c):
	for key in c:
		for pf in ['contract_on_behalf', 'contract_appeal_body']:
			if key.startswith(pf):
				del c[key]
		for t in ['contract_id', 'document_id', 'document_doc_no']:
			if key == t:
				del c[key]
	return c


def load_entity(loader, c, prefix, schemata=[], source_url=None):
	e = loader.make_entity(['organisation', 'web', 'address'] + schemata, source_url=source_url)
	e.set('name', c.pop(prefix + '_official_name'))
	e.set('address', c.pop(prefix + '_address', None))
	e.set('city', c.pop(prefix + '_town', None))
	e.set('postcode', c.pop(prefix + '_postal_code', None))
	e.set('country_code', c.pop(prefix + '_country', None))
	e.set('fax', c.pop(prefix + '_fax', None))
	e.set('phone', c.pop(prefix + '_phone', None))
	e.set('url', c.pop(prefix + '_url', None))
	e.set('email', c.pop(prefix + '_email', None))
	c.pop(prefix + '_slug', None)
	return e


def load(loader, c):
	c = cleanup(c)
	source_url = c.pop('document_doc_url')

	log.info("loading: %s, %s", c.get('contract_doc_no'), c.get('document_title_text'))
	op = c.get('contract_operator_official_name')
	if not op or not len(op.strip()):
		log.warning("No operator named, skipping!")
		return

	if 'European Institution' not in c['document_authority_type']:
		return
	authority = load_entity(loader, c, 'contract_authority',
		schemata=['public_body'], source_url=source_url)
	authority.set('public_body_type', c.pop('document_authority_type'))
	authority.save()

	operator = load_entity(loader, c, 'contract_operator', source_url=source_url)
	operator.save()

	tx = loader.make_relation('ted_contract_award', authority, operator,
		source_url=source_url)
	tx_id = '%s // %s' % (c['contract_doc_no'], c.pop('contract_index'))
	tx.unique('transaction_id')
	tx.set('transaction_id', tx_id)
	tx.set('document_no', c.pop('contract_doc_no', None))
	tx.set('activity_contractor', c.pop('contract_activity_contractor', None))
	tx.set('activity_type', c.pop('contract_activity_type', None))
	tx.set('activity_type_other', c.pop('contract_activity_type_other', None))
	tx.set('additional_information', c.pop('contract_additional_information', None))
	tx.set('appeal_procedure', c.pop('contract_appeal_procedure', None))
	tx.set('concessionaire_contact', c.pop('contract_concessionaire_contact', None))
	tx.set('concessionaire_email', c.pop('contract_concessionaire_email', None))
	tx.set('concessionaire_nationalid', c.pop('contract_concessionaire_nationalid', None))
	tx.set('contract_award_day', c.pop('contract_contract_award_day', None))
	tx.set('contract_award_month', c.pop('contract_contract_award_month', None))
	tx.set('contract_award_title', c.pop('contract_contract_award_title', None))
	tx.set('contract_award_year', c.pop('contract_contract_award_year', None))
	tx.set('contract_description', c.pop('contract_contract_description', None))
	tx.set('contract_number', c.pop('contract_contract_number', None))
	tx.set('contract_title', c.pop('contract_contract_title', None))
	tx.set('contract_type_supply', c.pop('contract_contract_type_supply', None))
	tx.set('contract_value_cost_eur', c.pop('contract_contract_value_cost_eur', None))
	tx.set('original_currency', c.pop('contract_contract_value_currency', c.pop('contract_initial_value_currency', None)))
	tx.set('contract_value_high_eur', c.pop('contract_contract_value_high_eur', None))
	tx.set('contract_value_low_eur', c.pop('contract_contract_value_low_eur', None))
	tx.set('contract_value_vat_included', c.pop('contract_contract_value_vat_included', None))
	tx.set('contract_value_vat_rate', c.pop('contract_contract_value_vat_rate', None))
	tx.set('cpv_code', c.pop('contract_cpv_code', None))
	tx.set('electronic_auction', c.pop('contract_electronic_auction', None))
	tx.set('file_reference', c.pop('contract_file_reference', None))
	tx.set('gpa_covered', c.pop('contract_gpa_covered', None))
	tx.set('initial_value_cost_eur', c.pop('contract_initial_value_cost_eur', None))
	tx.set('initial_value_vat_included', c.pop('contract_initial_value_vat_included', None))
	tx.set('initial_value_vat_rate', c.pop('contract_initial_value_vat_rate', None))
	tx.set('contract_location', c.pop('contract_location', None))
	tx.set('contract_location_nuts', c.pop('contract_location_nuts', None))
	tx.set('lot_number', c.pop('contract_lot_number', None))
	tx.set('offers_received_meaning', c.pop('contract_offers_received_meaning', None))
	tx.set('offers_received_num', c.pop('contract_offers_received_num', None))
	tx.set('relates_to_eu_project', c.pop('contract_relates_to_eu_project', None))
	tx.set('total_value_cost_eur', c.pop('contract_total_value_cost_eur', None))
	tx.set('total_value_high_eur', c.pop('contract_total_value_high_eur', None))
	tx.set('total_value_low_eur', c.pop('contract_total_value_low_eur', None))
	tx.set('total_value_vat_included', c.pop('contract_total_value_vat_included', None))
	tx.set('total_value_vat_rate', c.pop('contract_total_value_vat_rate', None))
	tx.set('type_contract', c.pop('contract_type_contract', None))
	tx.set('award_criteria', c.pop('document_award_criteria', None))
	tx.set('award_criteria_code', c.pop('document_award_criteria_code', None))
	tx.set('bid_type', c.pop('document_bid_type', None))
	tx.set('bid_type_code', c.pop('document_bid_type_code', None))
	tx.set('contract_nature', c.pop('document_contract_nature', None))
	tx.set('contract_nature_code', c.pop('document_contract_nature_code', None))
	tx.set('directive', c.pop('document_directive', None))
	tx.set('dispatch_date', c.pop('document_dispatch_date', None))
	tx.set('etendering_url', c.pop('document_etendering_url', None))
	tx.set('iso_country', c.pop('document_iso_country', None))
	tx.set('main_activities', c.pop('document_main_activities', None))
	tx.set('main_activities_code', c.pop('document_main_activities_code', None))
	tx.set('oj_collection', c.pop('document_oj_collection', None))
	tx.set('oj_date', c.pop('document_oj_date', None))
	tx.set('oj_number', c.pop('document_oj_number', None))
	tx.set('orig_language', c.pop('document_orig_language', None))
	tx.set('orig_nuts', c.pop('document_orig_nuts', None))
	tx.set('orig_nuts_code', c.pop('document_orig_nuts_code', None))
	tx.set('procedure', c.pop('document_procedure', None))
	tx.set('procedure_code', c.pop('document_procedure_code', None))
	tx.set('regulation', c.pop('document_regulation', None))
	tx.set('regulation_code', c.pop('document_regulation_code', None))
	tx.set('submission_date', c.pop('document_submission_date', None))
	tx.set('technical_form_lang', c.pop('document_technical_form_lang', None))
	tx.set('title_country', c.pop('document_title_country', None))
	tx.set('title_text', c.pop('document_title_text', None))
	tx.set('title_town', c.pop('document_title_town', None))
	tx.save() 

	#pprint(dict(c))
	loader.persist()


def load_all():
	loader = Loader()
	for c in ted_contracts():
		load(loader, c)

if __name__ == '__main__':
	load_all()
