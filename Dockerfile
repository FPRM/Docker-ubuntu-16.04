FROM       ubuntu:xenial
MAINTAINER Floprm "https://github.com/FPRM"



# compilers and basic tools
RUN apt-get update && apt-get install -y \
        
        curl \
        wget \
        nano \
        openssh-server \
        python2.7 \
        python-pip \
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
        lsb-release  \
        python-dev \
        libxml2-dev \
        libxslt1-dev \
        antiword \
        unrtf \
        poppler-utils \
        pstotext \
        tesseract-ocr \
        flac \
        ffmpeg \
        lame \
        libmad0 \
        libsox-fmt-mp3 \
        sox \
        libjpeg-dev \
        swig




RUN export LC_ALL=C
RUN /bin/bash -c "source ~/.bashrc"

# pip
#RUN wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py; python get-pip.py; rm -f /get-pip.py

#install ssh

RUN mkdir /var/run/sshd

RUN pip install textract
RUN echo 'root:medica' |chpasswd

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
# add keep alive in ssh_config every 30 seconds with max trial of 5 attempt
RUN echo 'ClientAliveInterval 30' >> /etc/ssh/sshd_config
RUN echo 'ServerAliveCountMax 5' >> /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
