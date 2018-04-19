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
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
