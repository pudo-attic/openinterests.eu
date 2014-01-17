import os
import time
import logging
import requests

log = logging.getLogger(__name__)


def get_cache_path():
	path = os.environ.get('OPINT_DATA_PATH')
	if path is None:
		path = '/tmp/opint_data'
		log.warning('No ETL data path (OPINT_DATA_PATH) set in environment, using: %s', path)
	if not os.path.isdir(path):
		os.makedirs(path)
	return os.path.abspath(path)


def ensure_path(sub_path):
	cache_path = get_cache_path()
	path = os.path.join(cache_path, sub_path)
	if not path.startswith(cache_path):
		log.warning('Cache path %s is outside of main path %s', path, cache_path)
	dir_path = os.path.dirname(path)
	if not os.path.isdir(dir_path):
		log.info('Directory %s does not exist, creating!', dir_path)
		os.makedirs(dir_path)
	return path


def fetch_data(url, local_path, max_age=None):
	path = ensure_path(local_path)

	if max_age is not None and os.path.isfile(path):
		age = time.time() - os.path.getmtime(path)
		if age > max_age:
			log.info("Discarding old version of %s", url)
			os.unlink(path)
	
	if not os.path.isfile(path):
		log.info('Downloading %s', url)
		res = requests.get(url)
		if res.status_code >= 400:
			log.warning('HTTP Error: %s', res.status_code)
			return
		with open(path, 'wb') as fh:
			for data in res.iter_content():
				fh.write(data)

	return path


def walk_path(sub_path):
	path = ensure_path(sub_path)
	for (dirpath, dirnames, filenames) in os.walk(path):
		for filename in filenames:
			yield os.path.join(dirpath, filename)


