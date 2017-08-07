#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest
import json
from decrypt import app


class DecrptMessageTestCase(unittest.TestCase):

    def setUp(self):
        app.testint = True
        self.app = app.test_client()

    def test_decrypt_message(self):
        rv = self.app.post('/decryptMessage', data=json.dumps(dict(Passphrase='topsecret',
                                                     Message='-----BEGIN PGP MESSAGE-----\nVersion: GnuPG v2\njA0ECQMCVady3RUyJw3X0kcBF+zdkfZOMhISoYBRwR3uk3vNv+TEg+rJnp4/yYIS\npEoI2S82cDiCNBIVAYWB8WKPtH2R2YSussKhpSJ4mFgqyOA01uwroA==\n=KvJQ\n-----END PGP MESSAGE-----')), content_type='application/json')

        self.assertEqual(rv.status_code, 200)
        self.assertIn(b'{"DecryptedMessage": "Nice work!\\n"}\n', rv.data)

    def test_decrypt_message_error(self):
        rv = self.app.post('/decryptMessage', data=json.dumps(dict(Passphrase='topsecret',
                                                     )), content_type='application/json')
        self.assertEqual(rv.status_code, 400)

    def test_decrypt_passphrase_error(self):
        rv = self.app.post('/decryptMessage', data=json.dumps(dict(Passphrase='', Message='''-----BEGIN PGP MESSAGE-----
                                            Version: GnuPG v2
                                            jA0ECQMCVady3RUyJw3X0kcBF+zdkfZOMhISoYBRwR3uk3vNv+TEg+rJnp4/yYIS
                                            pEoI2S82cDiCNBIVAYWB8WKPtH2R2YSussKhpSJ4mFgqyOA01uwroA==
                                            =KvJQ
                                            -----END PGP MESSAGE----- ''')), content_type='application/json')
        self.assertEqual(rv.status_code, 200)
        self.assertIn(
            b'{"Error": "Invalid Message or Passphrase"}\n', rv.data)

    def test_decrypt_error(self):
        rv = self.app.post('/decryptMessage', data=json.dumps(dict(Passphrase='',
                                                     Message='')), content_type='application/json')
        self.assertEqual(rv.status_code, 200)
        self.assertIn(
            b'{"Error": "Invalid Message or Passphrase"}\n', rv.data)


if __name__ == '__main__':
    unittest.main()
