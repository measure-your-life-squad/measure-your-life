FROM python:3.8.2-slim-buster

RUN mkdir /app
RUN mkdir /app_temp
COPY /requirements.txt /app_temp

RUN groupadd -r app && useradd --no-log-init -r -g app app

RUN pip3 install -r /app_temp/requirements.txt 

COPY /app.py /app

WORKDIR /app

USER app

ENTRYPOINT [ "python3", "app.py" ] 

EXPOSE 5000
