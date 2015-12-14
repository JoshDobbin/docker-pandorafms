FROM babim:ubuntubase

MAINTAINER "Duc Anh Babim" <ducanh.babim@yahoo.com>

RUN apt-get clean && \
    cat "deb http://www.artica.es/debian/squeeze /" > /etc/apt/sources.list.d/pandorafms.list
    apt-get update && \
    apt-get dist-upgrade -y --force-yes && \
    apt-get install pandorafms-console pandorafms-server pandorafms-agent-unix -y --force-yes && \
    apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove

# to allow access from outside of the container  to the container service
# at that ports need to allow access from firewall if need to access it outside of the server. 
EXPOSE 80