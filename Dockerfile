FROM python:3.9.7-alpine3.14

WORKDIR /opt/python

COPY . /opt/python

RUN chmod 755 app.py

CMD ["python3", "api.py"]