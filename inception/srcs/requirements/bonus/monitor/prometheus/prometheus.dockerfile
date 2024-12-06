# install alpine
FROM	alpine:3.21.0

# Install prometheus
RUN	<<EOF
apk update;
apk add --no-cache libc6-compat wget tar;
addgroup -S prometheus;
adduser -S -G prometheus prometheus;
wget https://github.com/prometheus/prometheus/releases/download/v2.47.0/prometheus-2.47.0.linux-amd64.tar.gz;
tar -xzf prometheus-2.47.0.linux-amd64.tar.gz;
mv prometheus-2.47.0.linux-amd64 /opt/prometheus;
chown -R prometheus:prometheus /opt/prometheus;
rm prometheus-2.47.0.linux-amd64.tar.gz
EOF

#cd workdir
WORKDIR /opt/prometheus

#expose port
EXPOSE 9090

#confi copy file
COPY conf/prometheus.yml /opt/prometheus/prometheus.yml

#switch to promehteus user
USER prometheus

#run prometheus
CMD ["./prometheus", "--config.file=/opt/prometheus/prometheus.yml", "--storage.tsdb.path=/opt/prometheus/data"]

