from grano.model import Schema, Project

def facet_schema_list(obj, facets):
    results = []
    project = Project.by_slug('openinterests')
    for facet in facets:
        schema = Schema.by_name(project, facet.get('term'))
        print 'schema', schema
        if schema is not None and not schema.hidden:
            results.append((schema, facet.get('count')))
    return results
