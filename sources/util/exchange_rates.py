import os
import requests
import json

from sources.util.db import engine


currency_table = engine['shd_currency_rates']
RATES = {}


def get_rate(source_currency, conversion_date):
    key = (source_currency, conversion_date)
    if not key in RATES:
        source_currency = source_currency.strip().upper()
        if source_currency == 'EUR':
            RATES[key] = 1
        else:
            app_id = os.environ.get('OPENEXCHANGERATES_APPID', 'f4999cad9a23487eb5eaae4448309134')
            row = currency_table.find_one(conversion_date=conversion_date)
            if row is None:
                url = 'http://openexchangerates.org/api/historical/%s.json' % conversion_date
                res = requests.get(url, params={'app_id': app_id})
                row = {
                    'json': res.content,
                    'conversion_date': conversion_date,
                    'url': url
                }
                currency_table.insert(row)
            data = json.loads(row.get('json'))
            eur_to_usd = data.get('rates').get('EUR')
            src_to_usd = data.get('rates').get(source_currency)
            if src_to_usd is not None:
                RATES[key] = (1/src_to_usd) * eur_to_usd
            else:
                RATES[key] = None
    return RATES[key]


def convert_currency(source_currency, conversion_date, amount):
    if amount is None:
        return None
    rate = get_rate(source_currency, conversion_date)
    if rate is None:
        return None
    return rate * float(amount)
