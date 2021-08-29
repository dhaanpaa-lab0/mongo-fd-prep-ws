#!/usr/bin/env bash

if [[ -z "${MONGODESTIMPURI}" ]]; then
  echo "You need to set the MONGODESTIMPURI environment variable or current shell var"
  exit 1
fi
out_dir=./imports
if [[ ! -d $out_dir ]]; then
  echo "You need to create directory $out_dir"
  exit 1
fi

cols=$(ls imports)
for file in $cols; do
  fileToImport=$(basename "$file")
  c=${file/.json/}
  echo "Importing $fileToImport to collection $c on $MONGODESTIMPURI"
  mongoimport --uri="$MONGODESTIMPURI" --mode=merge --jsonArray -c "$c" --file="$out_dir/${fileToImport}"
done

