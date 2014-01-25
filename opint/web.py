from grano.manage import manager
from grano.core import app

from opint.views.entities import entities
from opint.views.relations import relations
from opint.views.base import base


app.register_blueprint(entities)
app.register_blueprint(relations)
app.register_blueprint(base)
