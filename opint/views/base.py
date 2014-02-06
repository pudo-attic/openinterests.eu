from flask import Blueprint, render_template, make_response

from grano.model import Entity
from grano.logic.searcher import search_entities
from opint.views.util import facet_schema_list


base = Blueprint('base', __name__, static_folder='../static', template_folder='../templates')


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
