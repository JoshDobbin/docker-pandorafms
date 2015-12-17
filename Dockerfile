FROM babim/ubuntubase

MAINTAINER "Duc Anh Babim" <ducanh.babim@yahoo.com>

RUN apt-get clean && \
    echo "deb http://www.artica.es/debian/squeeze /" > /etc/apt/sources.list.d/pandorafms.list && \
    echo "deb http://ftp.us.debian.org/debian/ squeeze main non-free" >> /etc/apt/sources.list.d/pandorafms.list && \
    echo "deb http://ftp.at.debian.org/debian-backports/ squeeze-backports main" >> /etc/apt/sources.list.d/pandorafms.list

RUN apt-get update && \
    apt-get dist-upgrade -y --force-yes && \
    apt-get install pandorafms-console pandorafms-server pandorafms-agent-unix openssh-server -y --force-yes && \
    apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y

RUN mkdir /var/run/sshd
# set password root 123456
RUN echo 'root:123456' | chpasswd
# allow root ssh
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

CMD ["/usr/sbin/sshd", "-D"]
# to allow access from outside of the container  to the container service
# at that ports need to allow access from firewall if need to access it outside of the server. 
EXPOSE 80 22
