FROM python:3.8.2-slim-buster

RUN apt-get update && apt-get install sqlite3

RUN mkdir /app
RUN mkdir /app_temp
COPY /requirements.txt /app_temp

RUN groupadd -r app && useradd --no-log-init -r -g app app

RUN pip3 install -r /app_temp/requirements.txt

RUN rm -r /app_temp

WORKDIR /app
RUN chown -R app:app /app

USER app

COPY /web_app /app

RUN ./db_setup.sh

ENTRYPOINT [ "python3", "app.py" ] 

EXPOSE 5000
