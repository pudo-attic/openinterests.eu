from grano.manage import manager
from grano.core import app

from opint.views.entities import entities
from opint.views.base import base


app.register_blueprint(entities)
app.register_blueprint(base)


if __name__ == "__main__":
    manager.run()
