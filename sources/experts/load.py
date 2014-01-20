import logging
from pprint import pprint
from hashlib import sha1

from grano.service import Loader

from sources.experts.util import engine
from sources.experts.util import exp_group, exp_sub_group, exp_group_type
from sources.experts.util import exp_group_task, exp_group_associated_dg
from sources.experts.util import exp_group_policy_area, exp_group_note
from sources.experts.util import exp_group_member


log = logging.getLogger('sources.experts.load')
EXPERTS_URL = 'http://ec.europa.eu/transparency/regexpert/index.cfm?do=transparency.showList'


def load(loader, row):
    
    
    pprint(dict(row))


def load_all():
    loader = Loader(source_url=EXPERTS_URL)
    for row in exp_group:
        load(loader, row)


if __name__ == '__main__':
    load_all()
