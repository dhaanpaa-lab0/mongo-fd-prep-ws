OS := `uname`
ARCH := `uname -m`
MONGOEXPORTER := `which mongoexport`
DB := "ga"

all: prereqs run

prereqs:
	mkdir -p ./generator
	mkdir -p ./exports

clean:
	rm -rfv ./generator
	mkdir -p ./generator
	rm -rfv ./exports
	mkdir -p ./exports
	rm -rfv ./downloadedSchemaFiles

download-schema-from-host:
	./analyzer/getSchemasFromHost.sh

download:
	cd ./generator && \
	wget https://github.com/feliixx/mgodatagen/releases/download/v0.9.2/mgodatagen_0.9.2_${OS}_${ARCH}.tar.gz -O mgodatagen.tgz && \
	tar xzvf mgodatagen.tgz && \
	cd ..

generate: prereqs clean download
	./generator/mgodatagen -f config.json

export: prereqs clean
	./exporter/exportAsJson.sh ${DB} ./exports

run: prereqs clean download

