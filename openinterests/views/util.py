import babel.numbers
import babel.dates
import decimal
import locale
from datetime import datetime
from urlparse import urlparse
from slugify import slugify

from grano.core import app, url_for
from grano.model import Schema, Project, Entity


STOPWORDS = ['of', 'the', 'for', 'die', 'der', 'das', 'at', 'de', 
             'et', 'en', 'in', 'le', 'la', 'in', 'to', 'and']


def facet_schema_list(obj, facets):
    results = []
    project = Project.by_slug('openinterests')
    for facet in facets:
        schema = Schema.by_name(project, facet.get('term'))
        if schema is not None and not schema.hidden:
            results.append((schema, facet.get('count')))
    return results


def url_slug(text):
    if text is None:
        return ''
    parts = []
    for part in slugify(text).split('-'):
        if part not in STOPWORDS:
            parts.append(part)
    text = '-'.join(parts)
    return text[:255]



@app.template_filter('format_eur')
def format_eur(num):
    if num is None or (isinstance(num, basestring) and not len(num)):
        return '-'
    try:
        num = decimal.Decimal(num)
        num = babel.numbers.format_currency(num, "EUR", locale="en_US")
        return num.replace('.00', '')
    except Exception, e:
        raise
        return '-'


@app.template_filter('domain_name')
def domain_name(url):
    if url is None:
        return None
    url = urlparse(url)
    dom = url.hostname.lower()
    if dom.startswith('www.'):
        dom = dom[4:]
    return dom


@app.template_filter('entity_link')
def entity_link(entity, **kwargs):
    if isinstance(entity, Entity):
        id, name = entity.id, entity['name'].value
    else:
        id, name = entity.get('id'), entity.get('properties').get('name').get('value')
    return url_for('entities.view', id=id, slug=url_slug(name), **kwargs)


@app.template_filter('render_value')
def render_value(value):
    if isinstance(value, basestring):
        return render_value_text(value)
    if isinstance(value, int):
        return '<span class="numeric-value int-value">%d</span>' % value
    if isinstance(value, float):
        return '<span class="numeric-value float-value">%.2f</span>' % value
    if isinstance(value, bool):
        if value:
            return '<i class="fa fa-plus-square"></i> true'
        else:
            return '<i class="fa fa-minus-square"></i> false'
    if isinstance(value, datetime):
        return babel.dates.format_date(value, locale='en_US')
    return value


def render_value_text(text):
    if text is None:
        return ''
    texts = text.split('\n')
    if len(text) < 300:
        return '<p>' + '</p>\n<p>'.join(texts) + '</p>'
    LT = """<div class="longtext"><div class="snippet">%s
    <a class="expand" href="#">Read more...</a></div>
    <div class="full"><p>%s</p></div></div>"""
    snippet = texts[0] if len(texts[0]) < 350 else texts[0][:250] + '...'
    return LT % (snippet, '</p>\n<p>'.join(texts))
