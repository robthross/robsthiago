FROM docker.io/python:3.9.7-alpine3.14

WORKDIR /opt/python

COPY . /opt/python

RUN pip install flask

RUN chmod 755 api.py && export FLASK_APP=api

CMD ["flask", "run"]