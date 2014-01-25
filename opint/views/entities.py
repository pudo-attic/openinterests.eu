from flask import Blueprint, render_template

entities = Blueprint('entities', __name__, static_folder='../static', template_folder='../templates')


@entities.route('/search')
def search():
    return render_template('search.html')
