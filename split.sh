#!/bin/bash

set -eux

TMP_DIR='_tmp'

mkdir -p ${TMP_DIR}
rm -rf ${TMP_DIR}/*
cp schema.sql ${TMP_DIR}/
cd ${TMP_DIR}
gsed -i -e '/^SET.*/d' schema.sql
gcsplit --prefix='' schema.sql '/^-- Table/' '{*}'
rm schema.sql
rm 00

for FILE in `ls -1`; do
  TABLE_NAME=$(cat ${FILE} | grep 'CREATE TABLE' | grep -G '`.*`.`.*`' -o)
  FNAME="$(echo $FILE | sed 's/^0*//').sql"

  echo '# --- !Ups' > $FNAME
  cat $FILE >> $FNAME
  echo '# --- !Downs' >> $FNAME
  echo "DROP TABLE ${TABLE_NAME};" >> $FNAME

  rm $FILE
done

cd ..
rm -rf migrations
mv ${TMP_DIR} migrations

# copy migration files into migration
EVO_PATH=$1
rm -rf "${EVO_PATH}/*"
cp -r migrations/ ${EVO_PATH}
