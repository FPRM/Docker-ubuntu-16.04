FROM       ubuntu:16.04
MAINTAINER Floprm "https://github.com/FPRM"



RUN echo "deb http://archive.ubuntu.com/ubuntu/ xenial-proposed main restricted universe multiverse" > /etc/apt/sources.list
RUN echo "deb-src http://archive.canonical.com/ubuntu xenial partner" > /etc/apt/sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y


# compilers and basic tools
#RUN apt-get install -y  build-essential 
RUN apt-get install -y make 
RUN apt-get install -y gcc 
RUN apt-get install -y git-core 
RUN apt-get install -y curl 
RUN apt-get install -y wget 
RUN apt-get install -y nano 
RUN apt-get install -y apt-transport-https



# pip
RUN wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py; python get-pip.py; rm -f /get-pip.py

#install ssh
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

EXPOSE 22
#launch ssh process
CMD    ["/usr/sbin/sshd", "-D"]
