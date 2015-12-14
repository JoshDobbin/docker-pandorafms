FROM babim:ubuntubase

MAINTAINER "Duc Anh Babim" <ducanh.babim@yahoo.com>

RUN apt-get clean && \
    cat >>/etc/apt/sources.list.d/pandorafms.list <<EOM
    deb http://www.artica.es/debian/squeeze /
    EOM
    apt-get update && \
    apt-get dist-upgrade -y --force-yes && \
    apt-get install pandorafms-console pandorafms-server pandorafms-agent-unix -y --force-yes && \
    apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove

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
