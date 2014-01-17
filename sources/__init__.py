import sqlaload as sl

from lobbyfacts.core import app

def etl_engine():
    return sl.connect(app.config.get('ETL_URL'))

