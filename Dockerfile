FROM       ubuntu:xenial
MAINTAINER Floprm "https://github.com/FPRM"












RUN apt-get update



# compilers and basic tools
#RUN apt-get install -y  build-essential 
#RUN apt-get install -y make 
#RUN apt-get install -y gcc 
#RUN apt-get install -y git-core 
#RUN apt-get install -y curl 
#RUN apt-get install -y wget 
#RUN apt-get install -y nano 
#RUN apt-get install -y apt-transport-https



# pip
#RUN wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py; python get-pip.py; rm -f /get-pip.py

#install ssh
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

EXPOSE 22
#launch ssh process
CMD    ["/usr/sbin/sshd", "-D"]
