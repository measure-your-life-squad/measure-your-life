# Flask Back-End REST-API Server with MongoDB and Swagger

Source files for the Flask REST-API backend server <-> MongoDB stack with Swagger. 

## In order to run locally

1. Install Docker Engine appropriate to your platform: [Docker Engine Overview](https://docs.docker.com/install/)
2. [Install Docker Compose](https://docs.docker.com/compose/install/)
3. Navigate to the *measure-your-life* directory and create an *.env* file with the following environment variables:
```bash
SECRET_KEY=flasksecretkey
APISERVERPWD=apiserverpassword
APISERVERUSR=apiserveruser
MONGOINITDBDATABASE=mongodev
MONGOADMINUSR=admin
MONGOADMINPWD=adminpassword
MECONFIGMONGODBPORT=27017
```
4. Create a new empty directory *mongo_db/data/db* for the MongoDB container to persist db data.
5. Execute the following command (may require sudo privileges on linux):
    ```docker-compose up ```

Once the container are started, the Flask web server will be accessible at localhost:5000. Mongo-Express container can be used to inspect MongoDB state, it is accessible at localhost:8081. MongoDB database state will be persisted in the directory created in step 4. If you would like to clean the db state, simply remove the files from the *mongo_db/data/db* directory.


## REST API Definition

There is an API definition available for the project in the OpenAPI 3.0 format, which can be imported to programs such as Postman or Swagger.

When developing locally, Swagger UI is also directly coupled to the web server, at the following endpoint: ```localhost:5000/ui```
