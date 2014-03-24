from flask import Blueprint, render_template, request, Markup
from flask import redirect, url_for
from werkzeug.exceptions import NotFound

from grano.logic.searcher import search_entities
from grano.lib.pager import Pager
from grano.model import Entity, Relation
from openinterests.views.util import facet_schema_list


entities = Blueprint('entities', __name__, static_folder='../static', template_folder='../templates')


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
    searcher.add_facet('relations.schema.name', 20)
    pager = Pager(searcher, 'search')
    #list(pager)
    schemata_facet = facet_schema_list(Entity, searcher.get_facet('schemata.name'))
    relschema_facet = facet_schema_list(Relation, searcher.get_facet('relations.schema.name'))
    return render_template('search.html', searcher=searcher,
        pager=pager, schemata_facet=schemata_facet, relschema_facet=relschema_facet)


@entities.route('/entities/<id>')
def view(id):
    entity = Entity.by_id(id)
    if entity is None:
        raise NotFound()
    if entity.same_as is not None:
        return redirect(url_for('entities.view', id=entity.same_as))
    inbound_sections = []
    for schema in entity.inbound_schemata:
        pager_name = schema.name + '_in'
        pager = Pager(entity.inbound_by_schema(schema), pager_name, id=id, limit=15)
        inbound_sections.append((schema, pager))
    outbound_sections = []
    for schema in entity.outbound_schemata:
        pager_name = schema.name + '_out'
        pager = Pager(entity.outbound_by_schema(schema), pager_name, id=id, limit=15)
        outbound_sections.append((schema, pager))
    return render_template('entity.html', entity=entity,
        inbound_sections=inbound_sections,
        outbound_sections=outbound_sections,
        render_relation=render_relation)