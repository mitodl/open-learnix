FROM apache/apisix:3.14.0-debian

ADD docker-entrypoint-extended.sh /docker-entrypoint-extended.sh

USER root

# install some utils for network debugging
RUN apt-get update && apt-get install -y dnsutils

USER apisix

ENTRYPOINT ["/docker-entrypoint-extended.sh"]

CMD ["docker-start"]
