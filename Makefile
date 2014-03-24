.PHONY: env

env:
	

web:
	python openinterests/manage.py runserver

schema:
	python openinterests/manage.py db upgrade head
	python openinterests/manage.py schema_import openinterests schemata/address.yaml
	python openinterests/manage.py schema_import openinterests schemata/eu_body.yaml
	python openinterests/manage.py schema_import openinterests schemata/expert_group.yaml
	python openinterests/manage.py schema_import openinterests schemata/expert_group_associated.yaml
	python openinterests/manage.py schema_import openinterests schemata/expert_group_member.yaml
	python openinterests/manage.py schema_import openinterests schemata/fts_committment.yaml
	python openinterests/manage.py schema_import openinterests schemata/geolocated.yaml
	python openinterests/manage.py schema_import openinterests schemata/organisation.yaml
	python openinterests/manage.py schema_import openinterests schemata/person.yaml
	python openinterests/manage.py schema_import openinterests schemata/public_body.yaml
	python openinterests/manage.py schema_import openinterests schemata/reg_membership.yaml
	python openinterests/manage.py schema_import openinterests schemata/reg_role.yaml
	python openinterests/manage.py schema_import openinterests schemata/reg_turnover.yaml
	python openinterests/manage.py schema_import openinterests schemata/representative.yaml
	python openinterests/manage.py schema_import openinterests schemata/ted_contract_award.yaml
	python openinterests/manage.py schema_import openinterests schemata/web.yaml
	
index:
	python openinterests/manage.py index

reindex:
	python openinterests/manage.py flush_index
	python openinterests/manage.py index

aliases:
	python openinterests/manage.py alias_import openinterests data/aliases.csv
	python openinterests/manage.py alias_export openinterests data/aliases_out.csv


####################################################
# AskTheEU Loader 

asktheeu: env
	python sources/asktheeu/load.py


####################################################
# EC Financial Transparency System

fts-download: env
	python sources/fts/download.py

fts-parse: env
	python sources/fts/parse.py

fts-geocode: env
	python sources/fts/geocode.py

fts-countries: env
	python sources/fts/countries.py

fts-load: env
	python sources/fts/load.py

fts: fts-download fts-parse fts-countries fts-geocode fts-load


####################################################
# EC/EP Expert Groups 

experts-download: env
	python sources/experts/download.py

experts-parse: env
	python sources/experts/parse.py

experts-countries: env
	python sources/experts/countries.py

experts-load: env
	python sources/experts/load.py

experts: experts-download experts-parse experts-countries experts-load


####################################################
# Tenders Electronic Daily

ted-download: env
	python sources/ted/download.py

ted-parse: env
	python sources/ted/parse.py

ted-iso-list: env
	python sources/ted/iso_list.py

ted-isos: ted-iso-list
	sh scripts/update-ted.sh

ted-countries:
	python sources/ted/countries.py

ted-load: env
	python sources/ted/load.py

ted: ted-download ted-parse ted-countries ted-load


####################################################
# EC/EP Register of Interests

interests-parse: env
	python sources/interests/parse_interests.py

accredditations-parse: env
	python sources/interests/parse_accredit.py

interests-categories: env
	python sources/interests/categories.py

interests-geocode: env
	python sources/interests/geocode.py

interests-countries: env
	python sources/interests/countries.py

interests-load: env
	python sources/interests/load.py

interests: interests-parse accredditations-parse interests-categories interests-countries interests-geocode interests-load

