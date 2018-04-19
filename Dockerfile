FROM       ubuntu:xenial
MAINTAINER Floprm "https://github.com/FPRM"



# compilers and basic tools
RUN apt-get update && apt-get install -y \
        build-essential  \
        apt-utils \
        make \
        gcc \
        git-core \
        curl \
        wget \
        nano \
        openssh-server \
        python2.7 \
        python-pip 



# pip
#RUN wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py; python get-pip.py; rm -f /get-pip.py

#install ssh

RUN mkdir /var/run/sshd

RUN echo 'root:medica' |chpasswd

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config


EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
