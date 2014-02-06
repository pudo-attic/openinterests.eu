.PHONY: env

env:
	


schema:
	python opint/manage.py createdb
	python opint/manage.py schema_import schemata/address.yaml
	python opint/manage.py schema_import schemata/eu_body.yaml
	python opint/manage.py schema_import schemata/expert_group.yaml
	python opint/manage.py schema_import schemata/expert_group_associated.yaml
	python opint/manage.py schema_import schemata/expert_group_member.yaml
	python opint/manage.py schema_import schemata/fts_committment.yaml
	python opint/manage.py schema_import schemata/geolocated.yaml
	python opint/manage.py schema_import schemata/organisation.yaml
	python opint/manage.py schema_import schemata/person.yaml
	python opint/manage.py schema_import schemata/public_body.yaml
	python opint/manage.py schema_import schemata/reg_membership.yaml
	python opint/manage.py schema_import schemata/reg_role.yaml
	python opint/manage.py schema_import schemata/reg_turnover.yaml
	python opint/manage.py schema_import schemata/representative.yaml
	python opint/manage.py schema_import schemata/ted_contract_award.yaml
	python opint/manage.py schema_import schemata/web.yaml
	
index:
	python opint/manage.py index

reindex:
	python opint/manage.py flush_index
	python opint/manage.py index


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

