# Flask Back-End REST-API Server

Source files for the REST-API backend server of the project hosted on Flask.

## In order to run locally
1. First, create a python virtual environment:
    1. Install venv:
        ```pip3 install venv```
    2. Navigate to the *api_backend_server* directory and create a virtual environment:
        ```python3 -m venv ./venv```
    3. Activate the environment with:
        ```source bin/activate```
2. Run the flask server from within the environment with:
    ```python3 app.py```

## In order to run as a docker container
1. Install Docker Engine appropriate to your platform: [Docker Engine Overview](https://docs.docker.com/install/)
2. Navigate to the *api_backend_server* directory and execute the following command (may require sudo privileges on linux):
    ```docker build -t myl-backend:latest .```
3. Once the image is build, execute:
    ```docker container run -d -p 5000:5000 myl-backend:latest```

In both cases, the server will be accessible on localhost:5000.
