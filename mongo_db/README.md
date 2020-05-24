# MongoDB helper files for setup via docker-compose

Helper files for setup of the MongoDB database via docker-compose.

Table of Contents:

1. **data/db\***
    - directory for a docker bind mount, that the MongoDB will persist its data in
2. **create_user.sh**
    - bash script that gets injected with env vars provided to the MongoDB docker container by docker-compose
    - executes at docker entrypoint
    - initializes a database and creates an admin user
3. **init_db.js**
    - javascript script with dummy data (passwords are already hashed, as this is the way backend stores them in db)
    - executes at docker entrypoint
    - creates initial dummy users and dummy data
