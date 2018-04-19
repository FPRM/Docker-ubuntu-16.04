FROM       ubuntu:16.04
MAINTAINER Floprm "https://github.com/FPRM"

RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
RUN apt-get install -y wget
RUN cd ~
RUN mkdir python_install
RUN cd python_install
RUN wget https://www.python.org/ftp/python/2.7.9/Python-2.7.9.tgz
RUN tar -xvf Python-2.7.9.tgz
RUN cd Python-2.7.9
RUN ./configure
RUN make
RUN sudo make install


RUN apt-get install -y openssh-server

RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]
