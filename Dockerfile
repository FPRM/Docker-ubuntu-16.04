FROM       ubuntu:xenial
MAINTAINER Floprm "https://github.com/FPRM"

ENV export DEBIAN_FRONTEND=noninteractive

# compilers and basic tools
RUN apt-get update && apt-get install -y \
        tzdata

RUN ln -fs /usr/share/zoneinfo/EUROPE/Paris /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata
