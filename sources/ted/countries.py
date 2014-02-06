import logging
import requests

from sources.util import country_by_name
from sources.ted.util import engine, contracts_table


log = logging.getLogger(__name__)


def transform_prefix(prefix):
    log.info("Normalizing countries for %s...", prefix)
    field = prefix + '_country'
    for row in list(contracts_table.distinct(field)):
        name, code = country_by_name(row.get(field))
        if code is not None:
            row[prefix + '_country_common'] = name
            row[prefix + '_country_code'] = code
            contracts_table.update(row, [field])


def transform():
    transform_prefix('operator')
    transform_prefix('authority')


if __name__ == '__main__':
    transform()
