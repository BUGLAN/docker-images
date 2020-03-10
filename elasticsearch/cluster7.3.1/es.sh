mkdir -p /data/es731/data
chown 1000:1000 /data/es731/data

docker run -d -P --name=es731-01 -p 9201:9201 -p 9301:9301 -v ~/es731/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml -v /data/es731/data:/usr/share/elasticsearch/data registry.forchange.cn/public/base-elasticsearch:7.3.1
