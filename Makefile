OS := `uname`
ARCH := `uname -m`
MONGOEXPORTER := `which mongoexport`
# Change this variable to reflect the data to export from
DB := "tests"
.DEFAULT_GOAL := help
.PHONY: help

clean: ## "Clean up workspace folders"
	rm -rfv ./generator
	rm -rfv ./imports
	rm -rfv ./exports
	rm -rfv ./downloadedSchemaFiles

download-schema-from-host: ## Get Schema information from source database
	./analyzer/getSchemasFromHost.sh
	./analyzer/getSchemasFromHostText.sh

download-generator: ## Download fake data generator
	mkdir -pv ./generator
	cd ./generator && \
	wget https://github.com/feliixx/mgodatagen/releases/download/v0.9.2/mgodatagen_0.9.2_${OS}_${ARCH}.tar.gz -O mgodatagen.tgz && \
	tar xzvf mgodatagen.tgz && \
	cd ..

generate: download-generator ## Run fake data generator
	./generator/mgodatagen -f export-config.json

export: ## Export from local database to json files
	mkdir -pv ./exports
	./exporter/exportAsJson.sh ${DB} ./exports

copy-to-import: create-import-dir ## Copy from exports folder to imports folder
	cp -Rv ./exports/* ./imports

create-import-dir: ## Create Import folder for importing to database
	mkdir -pv ./imports

import: ## Import JSON Files from the imports folder to the destination database
	./importer/importAsJson.sh



help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sed -n 's/^\(.*\): \(.*\)##\(.*\)/\1:\3/p' \

