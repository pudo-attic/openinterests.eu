import logging
import requests

from sources.util import country_by_name
from sources.interests.util import engine, reg_representative


log = logging.getLogger(__name__)


def transform():
    log.info("Normalizing countries for registered interests...")
    for row in list(reg_representative.distinct('contact_country')):
        name, code = country_by_name(row.get('contact_country'))
        if code is not None:
            row['country_common'] = name
            row['country_code'] = code
            reg_representative.update(row, ['contact_country'])


if __name__ == '__main__':
    transform()
