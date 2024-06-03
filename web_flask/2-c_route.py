#!/usr/bin/python3
""" Write a script that starts a Flask web application """

from flask import Flask
app = Flask(__name__)


@app.route('/')
def hello_world():
    """ return hbnb """
    return 'Hello HBNB!'


@app.route('/hbnb')
def hello():
    """ return hbnb """
    return 'HBNB'


@app.route('/c/<text>')
def c_text(text):
    """ replace text with variable """
    text = text.replace('_', ' ')
    return 'c {}'.format(text)


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
