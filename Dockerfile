FROM babim/debianbase

MAINTAINER "Duc Anh Babim" <ducanh.babim@yahoo.com>

RUN apt-get clean && \
    echo "deb http://www.artica.es/debian/squeeze /" > /etc/apt/sources.list.d/pandorafms.list && \
    echo "deb http://ftp.us.debian.org/debian/ squeeze main non-free" >> /etc/apt/sources.list.d/pandorafms.list && \
    echo "deb http://ftp.at.debian.org/debian-backports/ squeeze-backports main" >> /etc/apt/sources.list.d/pandorafms.list

RUN apt-get update && \
    apt-get install pandorafms-console pandorafms-server pandorafms-agent-unix -y --force-yes && \
    apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y

# to allow access from outside of the container  to the container service
# at that ports need to allow access from firewall if need to access it outside of the server. 
EXPOSE 80

# Use baseimage-docker's init system.
ENV LC_ALL C.UTF-8
