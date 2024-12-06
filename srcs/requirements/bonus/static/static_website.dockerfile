#install alpine
FROM	alpine:3.21.0

#install busybox for hosting static site
RUN <<EOF
apk update;
apk add --no-cache python3
mkdir -p /var/www/html
EOF

#copy static site and py script for server
COPY	--chmod=644 /tools/index.html /var/www/html/index.html
COPY	--chmod=644 /tools/serve_index.py /var/www/html/serve_index.py

#set workdir
WORKDIR	/var/www/html

#expose port 
EXPOSE	3000

CMD ["python3", "serve_index.py"]

