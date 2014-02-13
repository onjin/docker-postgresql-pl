FROM ubuntu:12.04

MAINTAINER Marek Wywiał, onjinx@gmail.com

ENV DBNAME docker
ENV DBUSER docker
ENV DBPASS docker

RUN echo 'Acquire::Languages {"none";};' > /etc/apt/apt.conf.d/60language
RUN echo 'LANG="pl_PL.UTF-8"' > /etc/default/locale
RUN echo 'LANGUAGE="pl_PL:en"' >> /etc/default/locale
RUN locale-gen pl_PL.UTF-8
RUN update-locale pl_PL.UTF-8

run apt-get -qq update
run apt-get install -y wget psmisc
run echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pg.list
run wget --no-check-certificate --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
run apt-get update
run RUNLEVEL=1 DEBIAN_FRONTEND=noninteractive apt-get install -y postgresql-9.3 postgresql-contrib-9.3
add run.sh /usr/local/bin/run
add pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf
add postgresql.conf /etc/postgresql/9.3/main/postgresql.conf
run chown -R postgres /etc/postgresql
volume /var/lib/postgresql
expose 5432
cmd ["/bin/bash", "-e", "/usr/local/bin/run"]
