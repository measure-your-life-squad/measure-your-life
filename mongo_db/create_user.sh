#!/bin/bash
set -e

mongo <<EOF
use admin
db.createUser({
  user:  '${APISERVERUSR}',
  pwd: '${APISERVERPWD}',
  roles: [{
    role: 'readWrite',
    db: '${MONGO_INITDB_DATABASE}'
  }]
})
EOF