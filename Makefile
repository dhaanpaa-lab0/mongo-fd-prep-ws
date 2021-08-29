OS := `uname`
ARCH := `uname -m`
MONGOEXPORTER := `which mongoexport`
DB := "ga"

clean:
	rm -rfv ./generator
	rm -rfv ./imports
	rm -rfv ./exports
	rm -rfv ./downloadedSchemaFiles

download-schema-from-host:
	./analyzer/getSchemasFromHost.sh
	./analyzer/getSchemasFromHostText.sh

download-generator:
	mkdir -pv ./generator
	cd ./generator && \
	wget https://github.com/feliixx/mgodatagen/releases/download/v0.9.2/mgodatagen_0.9.2_${OS}_${ARCH}.tar.gz -O mgodatagen.tgz && \
	tar xzvf mgodatagen.tgz && \
	cd ..

generate: download-generator
	./generator/mgodatagen -f export-config.json

export: clean
	mkdir -pv ./exports
	./exporter/exportAsJson.sh ${DB} ./exports

copy-to-import: create-import-dir
	cp -Rv ./exports/* ./imports

create-import-dir:
	mkdir -pv ./imports

import:
	./importer/importAsJson.sh



