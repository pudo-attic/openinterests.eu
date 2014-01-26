from grano.model import Schema

def facet_schema_list(obj, facets):
    results = []
    for facet in facets:
        schema = Schema.cached(obj, facet.get('term'))
        if not schema.hidden:
            results.append((schema, facet.get('count')))
    return results
