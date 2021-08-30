#!/usr/bin/env bash
if [[ -z "${MONGODESTIMPURI}" ]]; then
  echo "You need to set the MONGODESTIMPURI environment variable or current shell var"
  exit 1
fi

IMPORT_DIRECTORY=./imports
if [[ ! -d $IMPORT_DIRECTORY ]]; then
  echo "You need to create directory $IMPORT_DIRECTORY"
  exit 1
fi

cols=$(ls $IMPORT_DIRECTORY)
for file in $cols; do
  fileToImport=$(basename "$file")
  COLLECTION_NAME=${file/.json/}
  echo "Importing $fileToImport to collection $COLLECTION_NAME on $MONGODESTIMPURI"
  mongoimport --uri="$MONGODESTIMPURI" --mode=merge --jsonArray -c "$COLLECTION_NAME" --file="$IMPORT_DIRECTORY/${fileToImport}"
done

