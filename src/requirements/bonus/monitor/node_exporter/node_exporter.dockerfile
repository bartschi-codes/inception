#install alpine
FROM	alpine:3.21.0

#install nodeexporter
RUN	<<EOF
apk update;
apk add --no-cache curl;
curl -L https://github.com/prometheus/node_exporter/releases/download/v1.6.0/node_exporter-1.6.0.linux-amd64.tar.gz | tar xz;
mv node_exporter-1.6.0.linux-amd64/node_exporter /usr/local/bin/ ;
chmod +x /usr/local/bin/node_exporter
EOF

#expose port for prometheus
EXPOSE 9100

#run node exporter
CMD ["node_exporter"]

