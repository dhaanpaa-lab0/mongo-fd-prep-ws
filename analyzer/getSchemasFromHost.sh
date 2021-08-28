#!/usr/bin/env bash


if [[ -z "${MONGOURI}" ]]; then
  echo "You need to set the MONGOURI environment variable or current shell var"
  exit 1
fi

out_dir=$(pwd)/downloadedSchemaFiles
mkdir -pv "$out_dir"

# mongo ${MONGOURI} --quiet --eval 'var collection = "zones", outputFormat="json"' ./analyzer/variety.js

db=${MONGOURI}

tmp_file="f1o23op1k23opadlfhsdofheinwvw.js"
echo "print('_ ' + db.getCollectionNames())" >$tmp_file
cols=$(mongo "$db" $tmp_file | grep '_' | awk '{print $2}' | tr ',' ' ')
for c in $cols; do
  # shellcheck disable=SC2016
  echo "Exporting Info from ${c}"
  mongo "${MONGOURI}" --quiet --eval "var collection = '${c}', outputFormat='json'" ./analyzer/variety.js > "$out_dir/${c}.json"
done
rm $tmp_file
