
fetch:
	python ted/scraper.py

parse:
	python ted/parser.py

freeze:
	rm -rf site/*
	cp -R ted/static site
	mkdir -p site/data
	pg_dump -f site/data/opented-latest.sql -c -O --inserts opented
	python ted/dump.py
	python ted/freeze.py

upload:
	s3cmd sync -c s3cmd.config --acl-public -M site/* s3://opented.pudo.org

all: fetch parse freeze upload

