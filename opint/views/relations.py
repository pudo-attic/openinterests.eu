from flask import Blueprint, render_template, request
from werkzeug.exceptions import NotFound

from grano.service import search_entities
from grano.lib.pager import Pager
from grano.model import Relation


relations = Blueprint('relations', __name__, static_folder='../static', template_folder='../templates')


@relations.route('/relations/<id>')
def view(id):
    relation = Relation.by_id(id)
    if relation is None:
        raise NotFound()
    return render_template('relation.html', relation=relation)
