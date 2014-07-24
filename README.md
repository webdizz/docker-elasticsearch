docker-elasticsearch
====================

[Docker](https://www.docker.com/) image to run [Elasticsearch](http://www.elasticsearch.org/) as a service.

### Features:

* Base image is [webdizz/baseimage-java8](https://github.com/webdizz/docker-baseimage-java8)
* Exposed ports: 9200 9300
* Volumes: /data 
 
### Getting started
 
    dooker run -d -p 9200:9200 -p 9300:9300 webdizz/elasticsearch  
