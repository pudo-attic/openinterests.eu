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


# AskTheEU Loader

asktheeu: env
	python openinterests/loaders/asktheeu.py

# EC Financial Transparency System

fts: env
	python openinterests/loaders/fts.py

# EC/EP Expert Groups

experts: env
	python openinterests/loaders/experts.py

# Tenders Electronic Daily

ted: env
	python openinterests/loaders/ted.py

# EC/EP Register of Interests

interests: env
	python openinterests/loaders/interests.py
