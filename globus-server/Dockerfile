# Container with Globus Server installed in a Centos 8 system

# Parent Centos 8 with EPEL repositories container 
FROM centos:7

# Install EPEL repository
RUN curl -LOs https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && yum -y install epel-release-latest-7.noarch.rpm

# Adding Globus Connect Server to packages and install Globus Connect Server
RUN curl -LOs https://downloads.globus.org/toolkit/globus-connect-server/globus-connect-server-repo-latest.noarch.rpm \
    && rpm --import https://downloads.globus.org/toolkit/gt6/stable/repo/rpm/RPM-GPG-KEY-Globus \
    && yum -y install globus-connect-server-repo-latest.noarch.rpm \
    && yum -y install globus-connect-server \
    && yum -y install wget

# Replace systemd
# repo: https://github.com/gdraheim/docker-systemctl-replacement
RUN wget https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl.py -O /bin/systemctl \
    && chmod +x /bin/systemctl

# /etc is the directory for globus's executables
WORKDIR /etc

# Adding server config file to container
ADD globus-connect-server.conf /etc/globus-connect-server.conf

# Adding script that creates endpoint to container
ADD entrypoint.sh ./
RUN chmod a+x entrypoint.sh

#Exposing ports Globus's GridFTP Server uses
EXPOSE 2811
EXPOSE 50000-51000 

#Exposing ports Globus's MyProxy Server uses
EXPOSE 7512

# Make data directory and location to store globus state
RUN mkdir -p /data \
    && mkdir -p /globus_state

CMD ["bash", "entrypoint.sh"]
