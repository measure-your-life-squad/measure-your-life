# Flask Back-End REST-API Server

Source files for the REST-API backend server of the project hosted on Flask.

## In order to run locally
1. First, create a python virtual environment:
    1. Install venv:
        ```bash
        pip3 install venv
        ```
    2. Navigate to the *api_backend_server* directory and create a virtual environment:
        ```bash
        python3 -m venv ./venv
        ```
    3. Activate the environment with:
        ```bash
        source bin/activate
        ```
2. Create a sqlite3 database:
    1. Install sqlite3:
        ```bash
        sudo apt-get install sqlite3
        ```
    2. Run a script initializing sqlite3 database
        ```bash
        ./db_setup.sh
        ``` 
3. Run the flask server from within the environment with:
    ```python3 app.py```


## In order to run as a docker container
1. Install Docker Engine appropriate to your platform: [Docker Engine Overview](https://docs.docker.com/install/)
2. Navigate to the *api_backend_server* directory and execute the following command (may require sudo privileges on linux):
    ```docker build -t myl-backend:latest .```
3. Create a sqlite3 database:
    1. Install sqlite3:
        ```bash
        sudo apt-get install sqlite3
        ```
4. Once the image is build, execute:
    ```docker container run -it -p 5000:5000 myl-backend:latest```

In both cases, the server will be accessible on localhost:5000. Please note, that the database state inside the container will be lost once the container is stopped and should never be used in production. If you require a persistent database for development purposes, mount the sqlite3 database to the container from your local file system.


## REST API Definition

There is an API definition available for the project in the OpenAPI 3.0 format, which can be imported to programs such as Postman or Swagger.