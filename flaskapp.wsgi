#! /usr/bin/env python 
# -*- coding: UTF-8 -*-

import sys
import os

activate_this = '/usr/local/src/gnupg_env/bin/activate_this.py'
execfile(activate_this, dict(__file__=activate_this))

sys.path.insert (0,'/usr/local/src/decrypt')
os.chdir('/usr/local/src/decrypt')

from decrypt import app as application

