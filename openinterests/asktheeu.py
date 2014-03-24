from urllib import urlencode
from flask import url_for

from grano.core import app

BASE_TEMPLATE = """Dear %s,

Under the right of access to documents in the EU treaties, as developed in Regulation 1049/2001, I am requesting documents which contain the following information:

%s

(For further information, see: %s)

Yours faithfully,"""

FTS_TEMPLATE = """Any documents relating to the financial committment published in the EC FTS %s, %s beneficiary: %s."""
TED_TEMPLATE = """Any documents relating to the contract award %s (TED), %s beneficiary: %s."""


def _fts(relation):
    title, topic = '', ''
    if relation['grant_subject'].value and len(relation['grant_subject'].value):
        title = relation['grant_subject'].value
        topic = 'subject "' + relation['grant_subject'].value + '";'
    else:
        title = relation.target['name'].value
        topic = ''
    #topic = relation.target['name'].value

    key = ''
    if relation['position_key'].value and len(relation['position_key'].value):
        key = '(Position key: %s)' % relation['position_key'].value

    if len(title) > 50:
        title = title[:50] + '...'
    title = title + ' / ' + relation['position_key'].value
    text = FTS_TEMPLATE % (key, topic, relation.target['name'].value)
    return title, text

def _ted(relation):
    title, text = relation['title_text'].value, ''

    if len(title) > 75:
        title = title[:75] + '...'
    #title = title + ' / ' + relation['document_no'].value
    topic = '"' + relation['title_text'].value + '"'
    text = TED_TEMPLATE % (relation['document_no'].value, topic,
        relation.target['name'].value)
    return title, text


@app.template_filter('relation_wob_link')
def relation_wob_link(relation):
    body, other = None, None
    if relation.source.has_schema('eu_body'):
        body = relation.source
        other = relation.target
    elif relation.target.has_schema('eu_body'):
        body = relation.target
        other = relation.source
    else:
        return None

    subject, text = '', ''
    ext_url = url_for('relations.view', id=relation.id, _external=True)

    if relation.has_schema('fts_committment'):
        subject, text = _fts(relation)
    elif relation.has_schema('ted_contract_award'):
        subject, text = _ted(relation)
    else:
        subject = other['name'].value
        if len(subject) > 75:
            subject = subject[:75] + '...'

    text = BASE_TEMPLATE % (body['name'].value, text, ext_url)
    #text = text + " For further information, see OpenInterests.eu: %s" % ext_url 
    #text = 'I am a banana!'
    query = urlencode({
        'tags': 'openinterests entity_id:%s relation_id:%s' % (body.id, relation.id),
        'title': subject.encode('utf-8'),
        'body': text.encode('utf-8')
        })
    url = entity_wob_link(body)
    return url + '?' + query


@app.template_filter('entity_wob_link')
def entity_wob_link(entity):
    url = 'http://www.asktheeu.org/en/new/'
    url = url + entity['asktheeu_slug'].value
    return url
