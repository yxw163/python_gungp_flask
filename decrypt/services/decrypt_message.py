# -*- coding: utf-8 -*-

from gnupg import GPG
from flask_restful import Resource, reqparse


class DecryptMessage(Resource):
    def __init__(self):
        self.gpg = GPG(gpgbinary='/usr/bin/gpg',
                       gnupghome='/usr/local/src/keys')

    def post(self):
        parser = reqparse.RequestParser(bundle_errors=True)
        parser.add_argument('Message', type=str,
                            required=True, location='json')
        parser.add_argument('Passphrase', type=str,
                            required=True, location='json')
        args = parser.parse_args(strict=True)

        if not args['Message'] or not args['Passphrase']:
            return {"Error": "Invalid Message or Passphrase"}

        decrypted = self.gpg.decrypt(
            args['Message'], passphrase=args['Passphrase'])

        if decrypted.ok:
            return {"DecryptedMessage": str(decrypted)}
        else:
            return {"Error": decrypted.status}
