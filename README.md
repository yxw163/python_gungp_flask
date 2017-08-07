# python_gungp_flask

A simple web service that uses GPG libiary to decrypt a message

Usage:
	Just run automated script ./deploy.sh in a AWS hosts, then:

	A web service called "decryptMessage" is hosted by Apache via the server's public IP (e.g. http://51.11.132.197/decryptMessage).
 
		i. The web service is built using Flask.
		ii. The web service accepts a JSON payload with the following parameters:
			1. Passphrase- The passphrase to use to decrypt the message.
			2. Message- The GPG encrypted message.
		iii. The web service can be executed using an HTTP POST.
		iv. The web service returns a JSON response that is either an error message (if bad input parameters are given) or a single response parameter (if good input parameters are given):
			1. DecryptedMessage- The given message, decrypted using GPG and the given Passphrase.
	The web service has unit tests:
		i. All available unit tests can be executed by running the following command on the server:
			/usr/local/src/run-tests.sh
		ii. After running, details about the tests are output (pass, fail, specific failure messages).
