#!/usr/bin/env python
# -*- coding: UTF-8 -*-

import os
from setuptools import setup, find_packages

setup(
	# Application name:
    name = 'decryptMessage',

    # Version number (initial):
    version='1.0',

    # Application author details:
    author='Xiaowei Yang',
    author_email='yangxw163@gmail.com',


    description='A simple web service that uses GPG to decrypt a message',

    # Packages
    packages=find_packages(),

    # Include additional files into the package
    include_package_data=True,

    zip_safe=False,

    # Dependent packages (distributions)
    install_requires=[
    	'Flask>=0.10.1',
    	'flask_restful',
    	'python-gnupg'
    ]
)