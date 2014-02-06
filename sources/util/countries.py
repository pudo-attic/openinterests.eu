import logging
import requests
import csv

import nomenklatura

dataset = nomenklatura.Dataset("iso-countries")


def country_by_name(name):
    try:
        entity = dataset.entity_by_name(name).dereference()
        return entity.name, entity.attributes.get('acronym')
    except nomenklatura.NoMatch, nm:
        dataset.create_entity(name)
        return name, None

if __name__ == '__main__':
    print country_by_name('Germany')
    print country_by_name('DE')
    print country_by_name('Deutschland')
