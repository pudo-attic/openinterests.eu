from grano.model import Schema, Project

def facet_schema_list(obj, facets):
    results = []
    project = Project.by_slug('openinterests')
    for facet in facets:
        schema = Schema.cached(project, obj, facet.get('term'))
        if not schema.hidden:
            results.append((schema, facet.get('count')))
    return results
