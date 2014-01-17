import logging
from sources.util.db import engine
from sources.util.cache import fetch_data, walk_path

logging.basicConfig(level=logging.DEBUG)

requests_log = logging.getLogger("requests")
requests_log.setLevel(logging.WARNING)

alembic_log = logging.getLogger("alembic")
alembic_log.setLevel(logging.WARNING)

dataset_log = logging.getLogger("dataset")
dataset_log.setLevel(logging.WARNING)
