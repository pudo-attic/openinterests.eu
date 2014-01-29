from flask import Blueprint, render_template, make_response

from grano.model import Entity
from grano.service import search_entities
from opint.views.util import facet_schema_list


base = Blueprint('base', __name__, static_folder='../static', template_folder='../templates')
ROBOTS = """
User-agent: *
Sitemap: /sitemap.xml
"""


@base.route('/')
def index():
    searcher = search_entities({})
    searcher.add_facet('schemata.name', 20)

    schemata_facet = facet_schema_list(Entity, searcher.get_facet('schemata.name'))
    
    return render_template('index.html', schemata_facet=schemata_facet)


@base.route('/about')
def about_page():
    return render_template('about.html')


@base.route('/data')
def data_page():
    return render_template('data.html')


@base.route('/robots.txt')
def robots_txt():
    res = make_response(ROBOTS)
    res.headers['Content-Type'] = 'text/plain'
    return res


@base.route('/sitemap.xml')
def sitemap_xml():
    entities = [(entity.id, entity.updated_at, entity.degree) \
        for entity in Entity.all().filter_by(same_as=None).limit(1000)]
    upper = max([e[2] for e in entities])
    entities = sorted(entities, key=lambda e: e[2], reverse=True)[:100]
    entities = [(i, d.strftime('%Y-%m-%d'), '%.2f' % (float(s)/upper)) for (i,d,s) in entities]
    res = make_response(render_template('sitemap.xml', entities=entities))
    res.headers['Content-Type'] = 'text/xml'
    return res

