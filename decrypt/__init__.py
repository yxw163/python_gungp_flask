# -*- coding: utf-8 -*-

from flask import Flask, render_template
from flask_restful import Api
from services import DecryptMessage

app = Flask(__name__)
api = Api(app)

api.add_resource(DecryptMessage, '/decryptMessage')


if __name__ == '__main__':
    app.run()
