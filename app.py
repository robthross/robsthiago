#!/usr/bin/python3

from flask import Flask, render_template
from prometheus_client import start_http_server, Summary
import random
import time

# Create a metric to track time spent and requests made.
REQUEST_TIME = Summary('request_processing_seconds', 'Time spent processing request')
app = Flask(__name__)

@app.route("/")
@app.route("/index.html")
def index():
    return render_template("index.html")

@app.route("/curso-html.html")
def produto():
    return render_template("curso-html.html")

@app.route("/curso-js.html")
def cnpj():
    return render_template("curso-js.html")



# Decorate function with metric.
@REQUEST_TIME.time()
def process_request(t):
    """A dummy function that takes some time."""
    time.sleep(t)

if __name__=="__main__":
    app.run(debug=True)
