import babel.numbers
import decimal
import locale

from grano.manage import manager
from urlparse import urlparse

from grano.core import app

from opint.views.entities import entities
from opint.views.relations import relations
from opint.views.base import base
from opint.asktheeu import relation_wob_link


@app.template_filter('format_eur')
def format_eur(num):
    if num is None or not len(num):
        return ''
    try:
        num = decimal.Decimal(num)
        num = babel.numbers.format_currency(num, "EUR", locale="en_US")
        return num.replace('.00', '')
    except Exception, e:
        raise
        return '-'


@app.template_filter('domain_name')
def domain_name(url):
    url = urlparse(url)
    dom = url.hostname.lower()
    if dom.startswith('www.'):
        dom = dom[4:]
    return dom


app.register_blueprint(entities)
app.register_blueprint(relations)
app.register_blueprint(base)
