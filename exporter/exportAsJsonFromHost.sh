#!/usr/bin/env bash
if [[ -z "${MONGOSRCEXPURI}" ]]; then
  echo "You need to set the MONGOSRCEXPURI environment variable or current shell var"
  exit 1
fi

EXPORT_DIR=./exports
if [ ! -d $EXPORT_DIR ]; then
  echo "You must create $EXPORT_DIR folder"
  exit 1
fi

if [ ! -f COLLECTIONS ]; then
  echo "You must setup COLLECTIONS file for the collections you want to export"
  exit 1
fi

while IFS= read -r line
do
  echo "Exporting Collection $line From: $MONGOSRCEXPURI"
  mongoexport --jsonArray --pretty --uri="$MONGOSRCEXPURI" -c "$line" -o "$EXPORT_DIR/$line.json"
done < <(grep -v '^ *#' < ./COLLECTIONS)
