FROM ubuntu:18.04

LABEL license="MIT License"
LABEL maintainer="christoph.preissner@gmail.com"

ARG FDB_VERSION="5.2.5"
ARG FDB_DEB_REVISION="1"

ARG FDB_PKG_URL="https://www.foundationdb.org/downloads/${FDB_VERSION}/ubuntu/installers"
ARG FDB_CLIENTS_PKG="foundationdb-clients_${FDB_VERSION}-${FDB_DEB_REVISION}_amd64.deb"
ARG FDB_SERVER_PKG="foundationdb-server_${FDB_VERSION}-${FDB_DEB_REVISION}_amd64.deb"

RUN apt-get update && apt-get install -y \
	dpkg \
	python \
	net-tools

ADD ${FDB_PKG_URL}/${FDB_CLIENTS_PKG} /tmp/${FDB_CLIENTS_PKG}
ADD ${FDB_PKG_URL}/${FDB_SERVER_PKG} /tmp/${FDB_SERVER_PKG}

RUN dpkg -i /tmp/${FDB_CLIENTS_PKG} /tmp/${FDB_SERVER_PKG} && \
	rm /tmp/${FDB_CLIENTS_PKG} /tmp/${FDB_SERVER_PKG}

COPY start-foundationdb.sh /usr/bin/start-foundationdb.sh

RUN chmod 755 /usr/bin/start-foundationdb.sh

ENTRYPOINT ["start-foundationdb.sh"]

EXPOSE 4500
