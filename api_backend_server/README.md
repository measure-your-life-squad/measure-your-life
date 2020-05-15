# Flask Back-End REST-API Server with MongoDB, Swagger, and SendGrid integration

Source files for the Flask REST-API backend server <-> MongoDB stack with Swagger and SendGrid integration.

## In order to run locally

1. Install Docker Engine appropriate to your platform: [Docker Engine Overview](https://docs.docker.com/install/)
2. [Install Docker Compose](https://docs.docker.com/compose/install/)
3. Navigate to the *measure-your-life* directory and create an *.env* file with the following environment variables:

    ```bash
    SECRET_KEY=flasksecretkey
    SECURITY_PASSWORD_SALT=flasksecuritysalt
    APISERVERPWD=apiserverpassword
    APISERVERUSR=apiserveruser
    MONGOINITDBDATABASE=mongodev
    MONGOADMINUSR=admin
    MONGOADMINPWD=adminpassword
    MECONFIGMONGODBPORT=27017
    SENDGRID_API_KEY=<<sendgrid api key>>
    ```

    SendGrid API Key is set as an environment variable in Travis CI, thus it is not required to define it in the yaml file.

4. Create a new empty directory *mongo_db/data/db* for the MongoDB container to persist db data.
5. Execute the following commands (may require sudo privileges on linux):
  
    ```docker-compose build```

    ```docker-compose up```

Once the containers are started, the Flask web server will be accessible at localhost:5000. Mongo-Express container can be used to inspect MongoDB state, it is accessible at localhost:8081. MongoDB database state will be persisted in the directory created in step 4. If you would like to clean the db state, simply remove the files from the *mongo_db/data/db* directory.

## REST API Definition

There is an API definition available for the project in the OpenAPI 3.0 format, which can be imported to programs such as Postman or Swagger.

When developing locally, Swagger UI is also directly coupled to the web server, at the following endpoint: ```localhost:5000/ui```

## In order to run and develop unit and integration tests

1. Install venv

    ```bash
    pip3 install venv
    ```

2. Navigate to the *measure-your-life* directory and create a Python virtual environment in the project root directory

   ```bash
   python3 -m venv ./venv --prompt MYL
   ```

3. Activate the environment

    ```bash
    source venv/bin/activate
    ```

4. Install the app requirements

    ```bash
    pip3 install -r api_backend_server/requirements.txt
    ```

5. Install test requirements

    ```bash
    pip3 install -r cicd_requirements.txt
    ```

6. Run the tests with pytest

    ```bash
    python3 -m pytest api_backend_server/tests/unit_tests
    ```

Note that for the integration tests, the backend servers need to be stood up before test executions.
