from flask import Blueprint, render_template, request, Markup
from flask import redirect, url_for
from werkzeug.routing import BaseConverter
from werkzeug.exceptions import NotFound

from grano.logic.searcher import search_entities
from grano.lib.pager import Pager
from grano.model import Entity, Relation
from grano.core import app
from openinterests.views.util import entity_link, url_slug
from openinterests.views.util import facet_schema_list


entities = Blueprint('entities', __name__, static_folder='../static', template_folder='../templates')

class IDConverter(BaseConverter):

    def __init__(self, url_map, *items):
        super(IDConverter, self).__init__(url_map)
    
    def to_python(self, value):
        if '-' in value:
            value, _ = value.split('-', 1)
        return value

app.url_map.converters['id'] = IDConverter


def render_relation(schema, direction, entity, relation):
    path = 'relations/%s.%s.html' % (schema.name, direction)
    if path not in entities.jinja_loader.list_templates():
        path = 'relations/default.%s.html' % direction
    return Markup(render_template(path, entity=entity,
        relation=relation))


@entities.route('/entities')
def search():
    searcher = search_entities(request.args)
    searcher.add_facet('schemata.name', 20)
    pager = Pager(searcher, 'search')
    #list(pager)
    schemata_facet = facet_schema_list(Entity, searcher.get_facet('schemata.name'))
    relschema_facet = facet_schema_list(Relation, searcher.get_facet('relations.schema.name'))
    return render_template('search.html', searcher=searcher,
        pager=pager, schemata_facet=schemata_facet, relschema_facet=relschema_facet)


@entities.route('/entities/<id:id>-<slug>')
@entities.route('/entities/<id>')
def view(id, slug=None):
    entity = Entity.by_id(id)
    if entity is None:
        raise NotFound()
    if entity.same_as is not None:
        canonical = Entity.by_id(entity.same_as)
        return redirect(entity_link(canonical))
    inbound_sections = []
    slug = url_slug(entity['name'].value)
    for schema in entity.inbound_schemata:
        pager_name = schema.name + '_in'
        pager = Pager(entity.inbound_by_schema(schema), pager_name, id=id, slug=slug, limit=15)
        inbound_sections.append((schema, pager))
    outbound_sections = []
    for schema in entity.outbound_schemata:
        pager_name = schema.name + '_out'
        pager = Pager(entity.outbound_by_schema(schema), pager_name, id=id, slug=slug, limit=15)
        outbound_sections.append((schema, pager))

    canonical_url = entity_link(entity, **dict(request.args.items()))
    entity_hairball = app.config.get('ENTITY_HAIRBALL', True)
    return render_template('entity.html', entity=entity,
        canonical_url=canonical_url,
        entity_hairball=entity_hairball,
        inbound_sections=inbound_sections,
        outbound_sections=outbound_sections,
        render_relation=render_relation)
