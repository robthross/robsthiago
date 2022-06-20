FROM docker.io/python:3.9.7-alpine3.14

WORKDIR /opt/python

COPY . /opt/python

RUN pip install Flask && pip install prometheus-client && pip install uwsgi

RUN chmod 755 app.py

CMD ["flask", "run", "--host=0.0.0.0"]
CMD ["uwsgi", "--socket 127.0.0.1:3031", "--wsgi-file app.py", "--callable app", "--processes 4, --threads 2", "--stats 127.0.0.1:9191" ]