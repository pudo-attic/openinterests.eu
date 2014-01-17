import logging

from sources.interests.util import reg_representative

log = logging.getLogger(__name__)

CATEGORIES = {
    u'I - Professional consultancies/law firms/self-employed consultants': 1,
    u'II - In-house lobbyists and trade/professional associations': 2,
    u'III - Non-governmental organisations': 3,
    u'IV - Think tanks, research and academic institutions': 4,
    u'V - Organisations representing churches and religious communities': 5,
    u'VI - Organisations representing local, regional and municipal authorities, other public or mixed entities, etc.': 6
    }

SUBCATEGORIES = {
    u'Law firms': 11,
    u'Professional consultancies': 12,
    u'Self-employed consultants': 13,
    u'Companies & groups': 21,
    u'Other similar organisations': 22,
    u'Trade unions': 23,
    u'Trade, business & professional associations': 24,
    u'Non-governmental organisations, platforms and networks and similar': 31,
    u'Academic institutions': 41,
    u'Think tanks and research institutions': 42,
    u'Organisations representing churches and religious communities': 51,
    u'Local, regional and municipal authorities (at sub-national level)': 61,
    u'Other public or mixed entities, etc.': 62
    }


def code_categories():
    for cat in list(reg_representative.distinct('main_category')):
        cat['main_category_id'] = CATEGORIES[cat['main_category']]
        reg_representative.upsert(cat, ['main_category'])


def code_subcategories():
    for cat in list(reg_representative.distinct('sub_category')):
        cat['sub_category_id'] = SUBCATEGORIES.get(cat['sub_category'])
        reg_representative.upsert(cat, ['sub_category'])


def transform():
    log.info("Applying categories to RegExp representatives...")
    code_categories()
    code_subcategories()

if __name__ == '__main__':
    transform()

