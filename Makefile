

env:
	. .env


####################################################
# EC Financial Transparency System

fts-download: env
	python sources/fts/download.py

fts-parse: env
	python sources/fts/parse.py

fts-geocode: env
	python sources/fts/geocode.py

fts: fts-download fts-parse fts-geocode


####################################################
# EC/EP Expert Groups 

experts-download: env
	python sources/experts/download.py

experts-parse: env
	python sources/experts/parse.py

experts: experts-download experts-parse


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

ted: ted-download ted-parse


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

interests: interests-parse accredditations-parse interests-categories interests-geocode

