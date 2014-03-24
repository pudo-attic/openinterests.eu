from flask.ext.assets import Environment
from flask.ext.assets import ManageAssets
from grano.manage import manager
from grano.core import app, url_for

from openinterests.views.entities import entities
from openinterests.views.relations import relations
from openinterests.views.base import base
from openinterests.asktheeu import relation_wob_link


assets = Environment(app)



app.register_blueprint(entities)
app.register_blueprint(relations)
app.register_blueprint(base)
