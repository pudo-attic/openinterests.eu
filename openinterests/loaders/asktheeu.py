import unicodecsv
from StringIO import StringIO
import requests

from openinterests.loaders.util import make_loader

SCHEMATA = ['organisation', 'web', 'public_body', 'eu_body']
URL = "http://www.asktheeu.org/en/body/all-authorities.csv"


def get_eu_bodies():
    res = requests.get(URL)
    reader = unicodecsv.DictReader(StringIO(res.content))
    for row in reader:
        yield row


def create_eu_bodies():
    loader = make_loader(source_url=URL)
    for body in get_eu_bodies():
        e = loader.make_entity(SCHEMATA,
            source_url='http://asktheeu.org/en/body/' + body.get('URL name'))
        e.set('name', body.pop('Name'))
        e.set('asktheeu_slug', body.pop('URL name'))
        e.set('asktheeu_notes', body.pop('Notes'))
        e.set('abbreviation', body.pop('Short name'))
        e.set('url', body.pop('Home page'))
        e.set('public_body_type', body.pop('Tags'))
        e.save()
    loader.persist()


if __name__ == '__main__':
    create_eu_bodies()
