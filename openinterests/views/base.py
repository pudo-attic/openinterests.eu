from flask import Blueprint, render_template, make_response
from flask import redirect, request

from grano.core import url_for
from grano.model import Entity
from grano.logic.searcher import search_entities
from opint.views.util import facet_schema_list


base = Blueprint('base', __name__, static_folder='../static', template_folder='../templates')


@base.route('/')
def index():
    searcher = search_entities(request.args)
    searcher.add_facet('schemata.name', 20)
    schemata_facet = facet_schema_list(Entity, searcher.get_facet('schemata.name'))
    return render_template('index.html', schemata_facet=schemata_facet)


@base.route('/bodies')
def bodies():
    eu_bodies = search_entities({}, sort_field=('num_relations', 'desc'))
    eu_bodies.limit(200)
    eu_bodies.add_filter('schemata.name', 'eu_body')
    return render_template('bodies.html', eu_bodies=eu_bodies)


@base.route('/about')
def about_page():
    return render_template('about.html')


@base.route('/data')
def data_page():
    return redirect(url_for('base.about_page'))
