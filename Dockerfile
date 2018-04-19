FROM       ubuntu:16.04
MAINTAINER Floprm "https://github.com/FPRM"



RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

# install ssh server
RUN apt-get -y install openssh-server; mkdir -p /var/run/sshd; locale-gen en_US en_US.UTF-8

# install supervisor
RUN apt-get -y install supervisor
ADD supervisord.conf /etc/supervisor/supervisord.conf
RUN mkdir -p /var/log/supervisor

# compilers and basic tools
RUN apt-get install -y gfortran build-essential make gcc build-essential git-core curl wget vim-tiny nano

# install python
ADD repo.sh /tmp/repo.sh
ADD fkrull-deadsnakes-precise.list /tmp/fkrull-deadsnakes-precise.list
RUN chmod 755 /tmp/repo.sh; /tmp/repo.sh
RUN apt-get update
RUN apt-get install -y python2.7 python2.7-dev

# database client
# sqllite, postgresql, mysql client
RUN apt-get install -y libsqlite3-dev sqlite3 postgresql-client-9.1 postgresql-client-common libpq5 libpq-dev libmysqlclient-dev

# needed for httplib2
RUN apt-get install -y libxml2-dev libxslt-dev

# distribute
RUN wget http://python-distribute.org/distribute_setup.py; python distribute_setup.py; rm -f /distribute*

# pip
RUN wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py; python get-pip.py; rm -f /get-pip.py

# python-PIL
RUN apt-get install -y python-imaging libpng-dev libfreetype6 libfreetype6-dev

# pyzmq
RUN apt-get install -y libzmq-dev

# hdf5
ADD hdf5_install.sh /tmp/hdf5_install.sh
RUN chmod 755 /tmp/hdf5_install.sh; /tmp/hdf5_install.sh

# blas
ADD blas.sh /tmp/blas.sh
RUN chmod 755 /tmp/blas.sh; /tmp/blas.sh
ENV BLAS /usr/local/lib/libfblas.a

# lapack
ADD lapack.sh /tmp/lapack.sh
RUN chmod 755 /tmp/lapack.sh; /tmp/lapack.sh
ENV LAPACK /usr/local/lib/liblapack.a

# virtualenv
# This gets a current version.  Do not use the version packaged with ubuntu
RUN pip install virtualenv==1.10.1

# scientific python packages
ADD packages.sh /tmp/packages.sh
ADD requirements.sh /tmp/requirements.sh
RUN chmod 755 /tmp/packages.sh; /tmp/packages.sh

# set root password
RUN echo 'root:root' | chpasswd

# motd
RUN rm -rf /etc/update-motd.d /etc/motd
ADD motd /etc/motd

EXPOSE 8888 22

# run container with supervisor
CMD ["/usr/bin/supervisord"]