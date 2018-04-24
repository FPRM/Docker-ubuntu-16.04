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
        python-pip \
        gawk \
        make \
        git curl \
        cmake \
        psmisc \
        g++ \
        python-matplotlib \
        python-serial \
        python-wxgtk3.0 \
        python-scipy \
        python-opencv \
        python-numpy \
        python-pyparsing \
        ccache realpath \
        libopencv-dev  \
        lsb-release 



# pip
#RUN wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py; python get-pip.py; rm -f /get-pip.py

#install ssh

RUN mkdir /var/run/sshd

RUN echo 'root:medica' |chpasswd

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
# add keep alive in ssh_config every 30 seconds with max trial of 5 attempt
RUN echo 'ClientAliveInterval 30' >> /etc/ssh/sshd_config
RUN echo 'ServerAliveCountMax 5' >> /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
