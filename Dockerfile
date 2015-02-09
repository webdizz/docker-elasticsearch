FROM webdizz/baseimage-java8:8u31

MAINTAINER Izzet Mustafaiev "izzet@mustafaiev.com"

# Set correct environment variables.
ENV     HOME /root

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Elasticsearch version
ENV     ELASTICSEARCH_VERSION 1.4.2
ENV     ELASTICSEARCH_URL https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.deb

# elasticsearch
RUN	cd /tmp \
	&& wget $ELASTICSEARCH_URL \
	&& dpkg -i /tmp/elasticsearch-${ELASTICSEARCH_VERSION}.deb \
	&& /usr/share/elasticsearch/bin/plugin -install karmi/elasticsearch-paramedic \
	&& /usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head \
	&& echo "cluster.name: logstash" >> /etc/elasticsearch/elasticsearch.yml

RUN mkdir -p /etc/service/elasticsearch/ /data && \
	chown elasticsearch:elasticsearch /data
ADD	elasticsearch.sh /etc/service/elasticsearch/run

EXPOSE 9200 9300

VOLUME /data

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
