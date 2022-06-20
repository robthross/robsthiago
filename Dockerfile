FROM docker.io/python:3.9.7-alpine3.14

WORKDIR /opt/python

COPY . /opt/python

RUN python -m pip install --upgrade pip && \
apk add gcc && \
apk add python3-dev && \
apk add build-base && \
apk add linux-headers && \
apk add pcre-dev && \
pip3 install Flask && \
pip3 install prometheus-client && \
pip3 install uwsgi

RUN chmod 755 app.py

CMD ["uwsgi", "--socket 127.0.0.1:3031 --wsgi-file app.py --callable app --processes 4 --threads 2 --stats 127.0.0.1:9191"]