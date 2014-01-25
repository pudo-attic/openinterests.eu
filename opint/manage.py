from grano.manage import manager
from grano.core import app

from opint.views.entities import entities

app.register_blueprint(entities)

if __name__ == "__main__":
    manager.run()
