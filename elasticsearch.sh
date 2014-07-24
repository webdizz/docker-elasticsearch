#!/bin/sh
exec setuser elasticsearch \
    java -Xms256m -Xmx1g -Xss256k -Djava.awt.headless=true -XX:+UseParNewGC \
    -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:+UseCMSInitiatingOccupancyOnly \
    -XX:+HeapDumpOnOutOfMemoryError -Delasticsearch -Des.pidfile=/tmp/elasticsearch.pid \
    -Des.path.home=/usr/share/elasticsearch -cp :/usr/share/elasticsearch/lib/elasticsearch-1.1.0.jar:/usr/share/elasticsearch/lib/*:/usr/share/elasticsearch/lib/sigar/* \
    -Des.default.config=/etc/elasticsearch/elasticsearch.yml -Des.default.path.home=/usr/share/elasticsearch \
    -Des.default.path.logs=/var/log/elasticsearch \
    -Des.default.path.data=/var/lib/elasticsearch -Des.default.path.work=/tmp/elasticsearch \
    -Des.default.path.conf=/etc/elasticsearch org.elasticsearch.bootstrap.Elasticsearch \
    >> /var/log/elasticsearch.log 2>&1
