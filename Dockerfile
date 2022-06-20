FROM docker.io/python:3.9.7-alpine3.14

WORKDIR /opt/python

COPY . /opt/python

RUN pip install Flask && pip install prometheus-client

RUN chmod 755 app.py

CMD ["flask", "run", "--host=0.0.0.0"]