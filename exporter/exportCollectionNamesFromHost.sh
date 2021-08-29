#!/usr/bin/env bash
if [[ -z "${MONGOSRCEXPURI}" ]]; then
  echo "You need to set the MONGOSRCEXPURI environment variable or current shell var"
  exit 1
fi

COLSFILE=$(pwd)/COLLECTIONS
rm -rf "$COLSFILE"


tfile=$(mktemp /tmp/ecnfh.XXXXXXXXX.js)
echo "print('_ ' + db.getCollectionNames())" >"$tfile"
cols=$(mongo "$MONGOSRCEXPURI" "$tfile" | grep '_' | awk '{print $2}' | tr ',' ' ')

for c in $cols; do
  echo "Adding collection '${c}' to ${COLSFILE}"
  echo "$c" >> "$COLSFILE"
done
rm "$tfile"
