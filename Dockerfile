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

##startup scripts  
#Pre-config scrip that maybe need to be run one time only when the container run the first time .. using a flag to don't 
#run it again ... use for conf for service ... when run the first time ...
RUN mkdir -p /etc/my_init.d
COPY startup.sh /etc/my_init.d/startup.sh
RUN chmod +x /etc/my_init.d/startup.sh

#pre-config scritp for different service that need to be run when container image is create 
#maybe include additional software that need to be installed ... with some service running ... like example mysqld
COPY pre-conf.sh /sbin/pre-conf
RUN chmod +x /sbin/pre-conf \
    && /bin/bash -c /sbin/pre-conf \
    && rm /sbin/pre-conf
    
# to allow access from outside of the container  to the container service
# at that ports need to allow access from firewall if need to access it outside of the server. 
EXPOSE 80

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
ENV LC_ALL C.UTF-8
