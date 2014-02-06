import logging
import requests

from sources.util import country_by_name
from sources.experts.util import engine, exp_group_member


log = logging.getLogger(__name__)


def transform():
    log.info("Normalizing countries for expert groups...")
    for row in list(exp_group_member.distinct('country')):
        name, code = country_by_name(row.get('country'))
        if code is not None:
            row['country_common'] = name
            row['country_code'] = code
            exp_group_member.update(row, ['country'])


if __name__ == '__main__':
    transform()
