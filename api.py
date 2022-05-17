#!/usr/bin/python3

from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"

@app.route("/meuproduto")
def produto():
    return "<p>Escola de Dente</p>"

@app.route("/api/v1/")
def cnpj():
    return "<p>315.883.988-11</p>"