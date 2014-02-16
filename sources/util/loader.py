from grano.logic import Loader

def make_loader(source_url=None):
    return Loader('openinterests', source_url=source_url, 
        project_label='OpenInterests.eu')
