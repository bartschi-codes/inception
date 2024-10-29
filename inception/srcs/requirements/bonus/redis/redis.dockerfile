
#install alpine
FROM	alpine:edge

#install redis
RUN	<<EOF
apk update;
apk add --no-cache redis
EOF

#copy redis config file
COPY	conf/redis.conf /etc/redis.conf

#expose redis port
EXPOSE	6379

#start redis
CMD	[ "redis-server", "/etc/redis.conf" ]	
