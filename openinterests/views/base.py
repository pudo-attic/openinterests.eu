from flask import Blueprint, render_template, make_response
from flask import redirect, request

from grano.core import db, url_for
from grano.model import Entity
from grano.es.searcher import Searcher
from openinterests.views.util import facet_schema_list
from openinterests.views.util import url_slug


base = Blueprint('base', __name__, static_folder='../static', template_folder='../templates')


@base.route('/')
def index():
    searcher = Searcher(request.args)
    searcher.add_facet('schemata.name', 20)
    schemata_facet = facet_schema_list(Entity, searcher.get_facet('schemata.name'))
    return render_template('index.html', schemata_facet=schemata_facet)


@base.route('/bodies')
def bodies():
    eu_bodies = Searcher(request.args,
        sort_field=('degree', 'desc'))
    eu_bodies.limit(200)
    eu_bodies.add_filter('schemata.name', 'eu_body')
    return render_template('bodies.html', eu_bodies=eu_bodies)


@base.route('/about')
def about_page():
    return render_template('about.html')


@base.route('/sitemap.xml')
def sitemap_xml():
    rp = db.session.execute("""
        SELECT e.id AS id, p.value_string AS name, e.updated_at AS updated
            FROM grano_entity e, grano_property p, grano_relation r
            WHERE e.id = p.entity_id AND p.name = 'name'
                AND p.value_string IS NOT NULL
                AND p.active = true
                AND (r.target_id = e.id OR r.source_id = e.id)
            GROUP BY e.id, p.value_string, e.updated_at
            ORDER BY COUNT(r.id) DESC
            LIMIT 49500
    """)
    entities = []
    while True:
        row = rp.fetchone()
        if row is None:
            break
        url = url_for('entities.view', id=row['id'], slug=url_slug(row['name']))
        entities.append((url, row['updated']))
    text = render_template('sitemap_simple.xml', entities=entities)
    res = make_response(text)
    res.headers['Content-Type'] = 'text/xml'
    return res
