from flask import Blueprint, render_template

base = Blueprint('base', __name__, static_folder='../static', template_folder='../templates')


@base.route('/')
def index():
    return render_template('index.html')


@base.route('/about')
def about_page():
    return render_template('about.html')


@base.route('/data')
def data_page():
    return render_template('data.html')
