#!/bin/bash

echo "Cek apakah database sudah ada tabel 'users'..."

RESULT=$(mysql -h "$DB_HOST" -u "$DB_USERNAME" -p"$DB_PASSWORD" -D "$DB_DATABASE" -e "SHOW TABLES LIKE 'users';" | grep users)

if [ -z "$RESULT" ]; then
  echo "Database kosong, mulai import SQL file..."
  mysql -h "$DB_HOST" -u "$DB_USERNAME" -p"$DB_PASSWORD" "$DB_DATABASE" < /var/www/html/adaptive_learning.sql
  echo "Berhasil Membuat DB"
else
  echo "Database sudah ada data, skip import."
fi

exec "$@"
