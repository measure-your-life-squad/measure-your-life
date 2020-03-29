#!/usr/bin/env bash

set -e

cd "`dirname $0`"

echo ".databases" | sqlite3 local.db

#python3.8 db_setup.py

chmod 777 local.db
