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


@app.template_filter('longtext')
def longtext(text):
    texts = text.split('\n')
    if len(text) < 300:
        return '<p>' + '</p>\n<p>'.join(texts) + '</p>'
    LT = """<div class="longtext"><div class="snippet">%s
    <a class="expand" href="#">Read more...</a></div>
    <div class="full"><p>%s</p></div></div>"""
    snippet = texts[0] if len(texts[0]) < 350 else texts[0][:250] + '...'
    return LT % (snippet, '</p>\n<p>'.join(texts))


app.register_blueprint(entities)
app.register_blueprint(relations)
app.register_blueprint(base)
