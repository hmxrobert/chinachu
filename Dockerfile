FROM centos:latest
MAINTAINER hmxrobert

RUN yum -y update
RUN yum -y install epel-release
RUN yum -y install nodejs npm --enablerepo=epel
RUN yum -y install  net-tools wget git unzip bzip2 gcc gcc-c++ make autogen automake kernel-devel patch perl-ExtUtils-MakeMaker libtool openssl-devel libboost-all-dev boost-devel

RUN mkdir -p ~/src
WORKDIR  /root/src
RUN wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
RUN tar xvzf yasm-1.3.0.tar.gz 
WORKDIR /root/src/yasm-1.3.0/
RUN /root/src/yasm-1.3.0/configure
RUN make
RUN make install

RUN useradd chinachu

USER chinachu

RUN git clone git://github.com/kanreisa/Chinachu.git /home/chinachu/chinachu

WORKDIR /home/chinachu/chinachu/

RUN echo 1 | /home/chinachu/chinachu/chinachu installer

VOLUME ["/mnt/chinachu"]

RUN ln -s /mnt/chinachu/config.json /home/chinachu/chinachu/chinachu/config.json
RUN ln -s /mnt/chinachu/rules.json /home/chinachu/chinachu/chinachu/rules.json

RUN mkdir /mnt/chinachu/recorded
RUN mkdir /mnt/chinachu/data
RUN mkdir /mnt/chinachu/log

RUN ln -s /mnt/chinachu/recorded /home/chinachu/chinachu/chinachu/recorded
RUN ln -s /mnt/chinachu/data /home/chinachu/chinachu/chinachu/data
RUN ln -s /mnt/chinachu/log /home/chinachu/chinachu/chinachu/log

USER root
RUN sh /home/chinachu/chinachu/chinachu service operator initscript | /etc/init.d/chinachu-operator
RUN sh /home/chinachu/chinachu/chinachu service wui initscript | /etc/init.d/chinachu-wui
RUN chmod +x /etc/init.d/chinachu-*

ADD init.sh /
RUN chmod +x /init.sh

EXPOSE 10772
EXPOSE 20772

CMD ["/init.sh"]
