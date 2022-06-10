#!/usr/bin/python3

from flask import Flask, render_template

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

if __name__=="__main__":
    app.run(debug=True)