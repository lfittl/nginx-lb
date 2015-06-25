FROM nginx

ADD https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

RUN rm -f /etc/nginx/conf.d/default.conf

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

RUN mkdir -p /etc/confd/conf.d /etc/confd/templates

ADD ./nginx.conf.tmpl /etc/confd/templates/nginx.conf.tmpl
ADD ./nginx.toml /etc/confd/conf.d/nginx.toml

CMD ["nginx", "-g", "daemon off;"]
