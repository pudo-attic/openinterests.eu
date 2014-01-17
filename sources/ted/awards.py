from pprint import pprint
from slugify import slugify

from sources.ted.util import Extractor
from sources.util.exchange_rates import convert_currency


LOOKUP = {
        'appeal_body': {
            'std': './/PROCEDURES_FOR_APPEAL/APPEAL_PROCEDURE_BODY_RESPONSIBLE//',
            'util': './/APPEAL_PROCEDURES/RESPONSIBLE_FOR_APPEAL_PROCEDURES//',
            'mil': './/PROCEDURES_FOR_APPEAL/APPEAL_PROCEDURE_BODY_RESPONSIBLE//'
        },
        'authority': {
            'std': './/CONTRACTING_AUTHORITY_INFORMATION_CONTRACT_AWARD/NAME_ADDRESSES_CONTACT_CONTRACT_AWARD//',
            'util': './/NAME_ADDRESSES_CONTACT_CONTRACT_AWARD_UTILITIES/CA_CE_CONCESSIONAIRE_PROFILE//',
            'mil': './/CONTRACTING_AUTHORITY_INFORMATION_CONTRACT_AWARD_DEFENCE//CA_CE_CONCESSIONAIRE_PROFILE//',
        },
        'award_dest': {
            'std': './/AWARD_OF_CONTRACT',
            'util': './FD_CONTRACT_AWARD_UTILITIES/AWARD_CONTRACT_CONTRACT_AWARD_UTILITIES',
            'mil': './/AWARD_OF_CONTRACT_DEFENCE'
        },
        'total_value': {
            'std': './/TOTAL_FINAL_VALUE/COSTS_RANGE_AND_CURRENCY_WITH_VAT_RATE',
            'util': './/OBJECT_CONTRACT_AWARD_UTILITIES/COSTS_RANGE_AND_CURRENCY_WITH_VAT_RATE',
            'mil': './/TOTAL_FINAL_VALUE/COSTS_RANGE_AND_CURRENCY_WITH_VAT_RATE'
        },
        'award_description': {
            'std': './/DESCRIPTION_AWARD_NOTICE_INFORMATION',
            'util': './/OBJECT_CONTRACT_AWARD_UTILITIES/DESCRIPTION_CONTRACT_AWARD_UTILITIES',
            'mil': './/DESCRIPTION_AWARD_NOTICE_INFORMATION_DEFENCE'
        },
        'short_desc': {
            'std': './/DESCRIPTION_AWARD_NOTICE_INFORMATION/SHORT_CONTRACT_DESCRIPTION/P',
            'util': './/DESCRIPTION_CONTRACT_AWARD_UTILITIES/SHORT_DESCRIPTION/P',
            'mil': './/DESCRIPTION_AWARD_NOTICE_INFORMATION_DEFENCE/SHORT_CONTRACT_DESCRIPTION/P'
        },
        'reference': {
            'std': './/ADMINISTRATIVE_INFORMATION_CONTRACT_AWARD/FILE_REFERENCE_NUMBER/P',
            'util': './/ADMINISTRATIVE_INFO_CONTRACT_AWARD_UTILITIES/REFERENCE_NUMBER_ATTRIBUTED/P',
            'mil': './/ADMINISTRATIVE_INFORMATION_CONTRACT_AWARD_DEFENCE/FILE_REFERENCE_NUMBER/P'
        },
        'additional_info': {
            'std': './/COMPLEMENTARY_INFORMATION_CONTRACT_AWARD/ADDITIONAL_INFORMATION/P',
            'util': './/COMPLEMENTARY_INFORMATION_CONTRACT_AWARD_UTILITIES/ADDITIONAL_INFORMATION/P',
            'mil': './/COMPLEMENTARY_INFORMATION_CONTRACT_AWARD/ADDITIONAL_INFORMATION/P'
        },
        'electronic_auction': {
            'std': './/F03_IS_ELECTRONIC_AUCTION_USABLE',
            'util': './/F06_IS_ELECTRONIC_AUCTION_USABLE',
            'mil': './/F18_IS_ELECTRONIC_AUCTION_USABLE'
        },
        'activity_type': {
            'std': './/TYPE_AND_ACTIVITIES_AND_PURCHASING_ON_BEHALF//TYPE_OF_ACTIVITY',
            'util': './/NOPATH',
            'mil': './/TYPE_AND_ACTIVITIES_OR_CONTRACTING_ENTITY_AND_PURCHASING_ON_BEHALF//TYPE_OF_ACTIVITY'
        },
        'activity_type_other': {
            'std': './/TYPE_AND_ACTIVITIES_AND_PURCHASING_ON_BEHALF//TYPE_OF_ACTIVITY_OTHER',
            'util': './/NOPATH',
            'mil': './/TYPE_AND_ACTIVITIES_OR_CONTRACTING_ENTITY_AND_PURCHASING_ON_BEHALF//TYPE_OF_ACTIVITY_OTHER'
        },
        'authority_type': {
            'std': './/TYPE_AND_ACTIVITIES_AND_PURCHASING_ON_BEHALF//TYPE_OF_CONTRACTING_AUTHORITY',
            'util': './/NOPATH',
            'mil': './/TYPE_AND_ACTIVITIES_OR_CONTRACTING_ENTITY_AND_PURCHASING_ON_BEHALF//TYPE_OF_CONTRACTING_AUTHORITY'
        },
        'authority_type_other': {
            'std': './/TYPE_AND_ACTIVITIES_AND_PURCHASING_ON_BEHALF//TYPE_AND_ACTIVITIES/TYPE_OF_CONTRACTING_AUTHORITY_OTHER',
            'util': './/NOPATH',
            'mil': './/TYPE_AND_ACTIVITIES_OR_CONTRACTING_ENTITY_AND_PURCHASING_ON_BEHALF/TYPE_AND_ACTIVITIES/TYPE_OF_CONTRACTING_AUTHORITY_OTHER'
        },
        'operator': {
            'std': './ECONOMIC_OPERATOR_NAME_ADDRESS//',
            'util': './/',
            'mil': './ECONOMIC_OPERATOR_NAME_ADDRESS//'
        },
    }



def _lookup(s, key):
    return LOOKUP[key][s]


def extract_address(ext, prefix, query):
    if query is None:
        return {}
    data = {
        prefix + '_official_name': ext.text(query+'OFFICIALNAME'),
        prefix + '_address': ext.text(query+'ADDRESS'),
        prefix + '_town': ext.text(query+'TOWN'),
        prefix + '_postal_code': ext.text(query+'POSTAL_CODE'),
        prefix + '_country': ext.attr(query+'COUNTRY', 'VALUE'),
        prefix + '_attention': ext.text(query+'ATTENTION'),
        prefix + '_phone': ext.text(query+'PHONE'),
        prefix + '_email': ext.text(query+'EMAIL') or ext.text(query+'E_MAIL'),
        prefix + '_fax': ext.text(query+'FAX'),
        prefix + '_url': ext.text(query+'URL_GENERAL') or ext.text(query+'URL'),
        prefix + '_url_buyer': ext.text(query+'URL_BUYER'),
        prefix + '_url_info': ext.text(query+'URL_INFORMATION'),
        prefix + '_url_participate': ext.text(query+'URL_PARTICIPATE')
    }

    if data[prefix + '_official_name'] is not None:
        data[prefix + '_slug'] = slugify(data[prefix + '_official_name'])

    for k, v in data.items():
        if v is None:
            del data[k]
    return data


def extract_values(ext, conversion_date, prefix, query):
    if query is None:
        return {}
    data = {
        prefix + '_currency': ext.attr(query, 'CURRENCY'),
        prefix + '_cost': ext.attr(query + '/VALUE_COST', 'FMTVAL'),
        prefix + '_low': ext.attr(query + '//LOW_VALUE', 'FMTVAL'),
        prefix + '_high': ext.attr(query + '//HIGH_VALUE', 'FMTVAL'),
        prefix + '_months': ext.attr(query + '//NUMBER_MONTHS', 'FMTVAL'),
        prefix + '_years': ext.attr(query + '//NUMBER_YEARS', 'FMTVAL'),
        prefix + '_vat_rate': ext.attr(query + '//VAT_PRCT', 'FMTVAL')
    }

    if ext.el.find(query + '/INCLUDING_VAT') is not None:
        data[prefix + '_vat_included'] = True
    if ext.el.find(query + '/EXCLUDING_VAT') is not None:
        data[prefix + '_vat_included'] = False

    for key in [prefix + '_cost', prefix + '_low', prefix + '_high']:
        value = data.get(key)
        if value is not None:
            currency = data.get(prefix + '_currency')
            data[key + '_eur'] = convert_currency(currency, conversion_date, value)

    for k, v in data.items():
        if v is None:
            del data[k]
    return data


def parse_award(root, lookup, conversion_date):
    ext = Extractor(root)
    contract = {
        'contract_number': ext.text('./CONTRACT_NUMBER') or ext.text('.//CONTRACT_NO'),
        'lot_number': ext.text('./LOT_NUMBER') or ext.text('.//LOT_NUMBER'),
        'contract_title': ext.text('./CONTRACT_TITLE/P') or ext.text('./CONTRACT_TITLE') or ext.text('.//TITLE_CONTRACT') or ext.text('.//TITLE_CONTRACT/P'),
        'contract_award_day': ext.text('.//CONTRACT_AWARD_DATE/DAY') or ext.text('.//DATE_OF_CONTRACT_AWARD/DAY'),
        'contract_award_month': ext.text('.//CONTRACT_AWARD_DATE/MONTH') or ext.text('.//DATE_OF_CONTRACT_AWARD/MONTH'),
        'contract_award_year': ext.text('.//CONTRACT_AWARD_DATE/YEAR') or ext.text('.//DATE_OF_CONTRACT_AWARD/YEAR'),
        'offers_received_num': ext.text('.//OFFERS_RECEIVED_NUMBER'),
        'offers_received_meaning': ext.text('.//OFFERS_RECEIVED_NUMBER_MEANING')
    }

    contract.update(extract_values(ext, conversion_date, 'contract_value', './/COSTS_RANGE_AND_CURRENCY_WITH_VAT_RATE'))
    contract.update(extract_values(ext, conversion_date, 'initial_value', './/INITIAL_ESTIMATED_TOTAL_VALUE_CONTRACT'))
    contract.update(extract_address(ext, 'operator', lookup('operator')))
    #from lxml import etree
    #print etree.tostring(root, pretty_print=True)
    #pprint(contract)
    #ext.audit()
    return contract


def parse_form(root):
    form_type = 'std'
    if 'DEFENCE' in root.tag:
        form_type = 'mil'
    elif 'UTILITIES' in root.tag:
        form_type = 'util'

    lookup = lambda k: _lookup(form_type, k)

    ext = Extractor(root)
    form = {
        'file_reference': ext.text(lookup('reference')),
        'relates_to_eu_project': ext.text('.//RELATES_TO_EU_PROJECT_YES/P'),
        'notice_dispatch_day': ext.text('.//NOTICE_DISPATCH_DATE/DAY'),
        'notice_dispatch_month': ext.text('.//NOTICE_DISPATCH_DATE/MONTH'),
        'notice_dispatch_year': ext.text('.//NOTICE_DISPATCH_DATE/YEAR'),
        'appeal_procedure': ext.text('.//PROCEDURES_FOR_APPEAL//LODGING_OF_APPEALS_PRECISION/P'),
        'location': ext.text(lookup('award_description')+'/LOCATION_NUTS/LOCATION/P') or ext.text(lookup('award_description')+'/LOCATION_NUTS/LOCATION'),
        'location_nuts': ext.attr(lookup('award_description')+'/LOCATION_NUTS/NUTS', 'CODE'),
        'type_contract': ext.attr(lookup('award_description')+'//TYPE_CONTRACT', 'VALUE'),
        'gpa_covered': ext.attr(lookup('award_description')+'/CONTRACT_COVERED_GPA', 'VALUE'),
        'electronic_auction': ext.attr(lookup('electronic_auction'), 'VALUE'),
        'cpv_code': ext.attr(lookup('award_description')+'/CPV/CPV_MAIN/CPV_CODE', 'CODE'),
        'reason_lawful': ext.html('.//REASON_CONTRACT_LAWFUL'),
        #'cpv_additional_code': ext.attr('.//DESCRIPTION_AWARD_NOTICE_INFORMATION/CPV/CPV_ADDITIONAL/CPV_CODE', 'CODE'),
        'authority_type': ext.text(lookup('authority_type'), 'VALUE'),
        'authority_type_other': ext.text(lookup('authority_type_other'), 'VALUE'),
        'activity_type': ext.text(lookup('activity_type')),
        'activity_type_other': ext.text(lookup('activity_type_other')),
        'activity_contractor': ext.attr('.//ACTIVITIES_OF_CONTRACTING_ENTITY/ACTIVITY_OF_CONTRACTING_ENTITY', 'VALUE'),
        'concessionaire_email': ext.text('.//CA_CE_CONCESSIONAIRE_PROFILE/E_MAILS/E_MAIL'),
        'concessionaire_nationalid': ext.text('.//CA_CE_CONCESSIONAIRE_PROFILE/ORGANISATION/NATIONALID'),
        'concessionaire_contact': ext.text('.//CA_CE_CONCESSIONAIRE_PROFILE/CONTACT_POINT'),
        'contract_award_title': ext.text(lookup('award_description')+'/TITLE_CONTRACT/P'),
        'contract_description': ext.html(lookup('short_desc')),
        'additional_information': ext.html(lookup('additional_info')),
        'contract_type_supply': ext.attr('.//TYPE_CONTRACT_LOCATION_W_PUB/TYPE_SUPPLIES_CONTRACT', 'VALUE')
    }

    form.update(extract_address(ext, 'authority', lookup('authority')))
    form.update(extract_address(ext, 'appeal_body', lookup('appeal_body')))
    form.update(extract_address(ext, 'on_behalf', './/TYPE_AND_ACTIVITIES_AND_PURCHASING_ON_BEHALF/PURCHASING_ON_BEHALF//'))
    #form.update(extract_address(ext, 'lodging_info', './/PROCEDURES_FOR_APPEAL/LODGING_INFORMATION_FOR_SERVICE//'))
    ext.ignore('.//PROCEDURES_FOR_APPEAL/MEDIATION_PROCEDURE_BODY_RESPONSIBLE/*')
    ext.ignore('.//PROCEDURES_FOR_APPEAL/LODGING_INFORMATION_FOR_SERVICE/*')
    ext.ignore('./FD_CONTRACT_AWARD_DEFENCE/COMPLEMENTARY_INFORMATION_CONTRACT_AWARD/PROCEDURES_FOR_APPEAL/LODGING_INFORMATION_FOR_SERVICE/*')
    ext.ignore('./FD_CONTRACT_AWARD_UTILITIES/CONTRACTING_ENTITY_CONTRACT_AWARD_UTILITIES/NAME_ADDRESSES_CONTACT_CONTRACT_AWARD_UTILITIES/INTERNET_ADDRESSES_CONTRACT_AWARD_UTILITIES/URL_GENERAL')
    ext.ignore('./FD_CONTRACT_AWARD_UTILITIES/COMPLEMENTARY_INFORMATION_CONTRACT_AWARD_UTILITIES/APPEAL_PROCEDURES/SERVICE_FROM_INFORMATION/*')
    ext.ignore('./FD_CONTRACT_AWARD_UTILITIES/PROCEDURES_CONTRACT_AWARD_UTILITIES/ADMINISTRATIVE_INFO_CONTRACT_AWARD_UTILITIES/PREVIOUS_PUBLICATION_INFORMATION_NOTICE_F6/*')

    # Make awards criteria their own table.
    ext.ignore('./FD_CONTRACT_AWARD/PROCEDURE_DEFINITION_CONTRACT_AWARD_NOTICE/AWARD_CRITERIA_CONTRACT_AWARD_NOTICE_INFORMATION/AWARD_CRITERIA_DETAIL_F03/*')
    ext.ignore('./FD_CONTRACT_AWARD_UTILITIES/PROCEDURES_CONTRACT_AWARD_UTILITIES/F06_AWARD_CRITERIA_CONTRACT_UTILITIES_INFORMATION/*')
    ext.ignore('./FD_CONTRACT_AWARD_DEFENCE/PROCEDURE_DEFINITION_CONTRACT_AWARD_NOTICE_DEFENCE/AWARD_CRITERIA_CONTRACT_AWARD_NOTICE_INFORMATION_DEFENCE/AWARD_CRITERIA_DETAIL_F18/*')
    ext.ignore('.FD_CONTRACT_AWARD_UTILITIES/PROCEDURES_CONTRACT_AWARD_UTILITIES/F06_AWARD_CRITERIA_CONTRACT_UTILITIES_INFORMATION/PRICE_AWARD_CRITERIA/*')
    ext.ignore('./FD_CONTRACT_AWARD_DEFENCE/PROCEDURE_DEFINITION_CONTRACT_AWARD_NOTICE_DEFENCE/ADMINISTRATIVE_INFORMATION_CONTRACT_AWARD_DEFENCE/PREVIOUS_PUBLICATION_INFORMATION_NOTICE_F18/*')
    ext.ignore('./FD_CONTRACT_AWARD/AWARD_OF_CONTRACT/*')
    ext.ignore('./FD_CONTRACT_AWARD_DEFENCE/AWARD_OF_CONTRACT_DEFENCE/*')
    ext.ignore('./FD_CONTRACT_AWARD_UTILITIES/AWARD_CONTRACT_CONTRACT_AWARD_UTILITIES/*')
    ext.ignore('./FD_CONTRACT_AWARD_UTILITIES/OBJECT_CONTRACT_AWARD_UTILITIES/DESCRIPTION_CONTRACT_AWARD_UTILITIES/SHORT_DESCRIPTION/*')
    ext.ignore('./FD_CONTRACT_AWARD/PROCEDURE_DEFINITION_CONTRACT_AWARD_NOTICE/ADMINISTRATIVE_INFORMATION_CONTRACT_AWARD/PREVIOUS_PUBLICATION_INFORMATION_NOTICE_F3/*')

    ext.text('.//TYPE_CONTRACT_LOCATION_W_PUB/SERVICE_CATEGORY_PUB')
    ext.text('.//CPV/CPV_ADDITIONAL/CPV_CODE')
    
    conversion_date = '%s-%s-01' % (form['notice_dispatch_year'], form['notice_dispatch_month'])
    form.update(extract_values(ext, conversion_date, 'total_value', lookup('total_value')))

    #from lxml import etree
    #el = root.find('./FD_CONTRACT_AWARD/OBJECT_CONTRACT_INFORMATION_CONTRACT_AWARD_NOTICE/TOTAL_FINAL_VALUE')
    #if el:
    #    print etree.tostring(el, pretty_print=True)
    #    #pprint(form)
    #ext.audit()
    
    contracts = []
    for award in root.findall(lookup('award_dest')):
        contract = parse_award(award, lookup, conversion_date)
        contract.update(form)
        contracts.append(contract)
        #pprint(contract)
    return contracts
