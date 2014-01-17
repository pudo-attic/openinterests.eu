from sources.util import engine

fts_entry = engine['fts_entry']


def process_rows(handlefunc, engine=None):
    if engine is None:
        engine = make_engine()
    table = sl.get_table(engine, 'fts')
    for row in sl.all(engine, table):
        out = handlefunc(row)
        sl.upsert(engine, table, out, ['id'])
    return table

