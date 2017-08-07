#!/bin/bash
#
#    Description:
#        1: This simple script is install apache and it’s prerequisites for flask web 
#        application.
#        2: Automatically deploy decrypt application
#

dir=`pwd`

#-------------------install gcc gcc-c++----------------------
if [[ `gcc --version` == "" ]]
then
    yum -y install gcc gcc-c++
fi
#------------------------------------------------------------

#-------------------install apr------------------------------
if [[ `ls|grep apr` == "" ]]
then
    wget http://mirrors.cnnic.cn/apache//apr/apr-1.5.2.tar.gz
fi

tar -zxvf apr-1.5.2.tar.gz
mkdir /usr/local/lib/apr-1.5.2
cd $dir/apr-1.5.2
./configure --prefix=/usr/local/lib/apr-1.5.2 
make
make install
#------------------------------------------------------------

#------------------install apr-util--------------------------
cd $dir
if [[ `ls|grep apr-util` == "" ]]
then
    wget http://mirrors.cnnic.cn/apache//apr/apr-util-1.5.4.tar.gz
fi

tar -zxvf apr-util-1.5.4.tar.gz
mkdir /usr/local/lib/apr-util-1.5.4.tar.gz
cd $dir/apr-util-1.5.4
./configure --prefix=/usr/local/lib/apr-util-1.5.4 --with-apr=/usr/local/lib/apr-1.5.2
make 
make install
#------------------------------------------------------------

#------------------------install pcre------------------------
cd $dir
if [[ `ls|grep pcre` == "" ]]
then
    wget http://ncu.dl.sourceforge.net/project/pcre/pcre/8.37/pcre-8.37.tar.gz
fi
tar -zxvf pcre-8.37.tar.gz
mkdir /usr/local/lib/pcre-8.37
cd $dir/pcre-8.37
./configure --prefix=/usr/local/lib/pcre-8.37
make 
make install
#------------------------------------------------------------

#------------------install apache----------------------------
cd $dir
if [[ `ls|grep httpd-2.4.27` == "" ]]
then
    wget http://www.apache.org/dist/httpd/httpd-2.4.27.tar.gz
fi
tar -zxvf httpd-2.4.27.tar.gz
mkdir /usr/local/lib/httpd-2.4.27
cd $dir/httpd-2.4.27
./configure --prefix=/usr/local/lib/httpd-2.4.27 --with-apr=/usr/local/lib/apr-1.5.2  --with-apr-util=/usr/local/lib/apr-util-1.5.4 --with-pcre=/usr/local/lib/pcre-8.37  --enable-so
make
make install
#------------------------------------------------------------

#----------------------install mod_wsgi----------------------
cd $dir
if [[ `ls|grep mod_wsgi` == "" ]]
then
    wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/modwsgi/mod_wsgi-3.4.tar.gz
fi
tar -zxvf mod_wsgi-3.4.tar.gz
mkdir /usr/local/lib/mod_wsgi-3.4
cd $dir/mod_wsgi-3.4
./configure --with-apxs=/usr/local/lib/httpd-2.4.27/bin/apxs --with-python=/usr/bin/python
make
make install
#------------------------------------------------------------

sed -i 's/^#ServerName www.example.com:80/ServerName localhost/g' /usr/local/lib/httpd-2.4.27/conf/httpd.conf

#configure apache
cd $dir
if [[ `ls|grep httpd.conf` != "" ]]
then
	cp httpd.conf /usr/local/lib/httpd-2.4.27/conf
fi

if [ `pgrep httpd | wc -l` == 0 ]
then
    /usr/local/lib/httpd-2.4.27/bin/apachectl start
else
    /usr/local/lib/httpd-2.4.27/bin/apachectl restart
fi

if [[ `curl -s localhost:80|grep "It works"` != "" ]]
then
    echo "----------------------Install Success-------------------------------------"
fi

#-----------install decryptMessage-flask-app-------------------
#1 install a python env with virtualenv
cd $dir
if [[ `ls|grep gnupg_env` == "" ]]
then
	virtualenv gnupg_env
else
	rm -rf gnupg_env
    virtualenv gnupg_env
fi

#2 activate python env
source $dir/gnupg_env/bin/activate

#3 deploy decryptMessage application
cd $dir
mkdir keys
python setup.py install

