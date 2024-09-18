FROM ubuntu:22.04 as builder
ARG VERSION=2.7.2.Final
RUN apt update && apt install wget -y && \
    cd /tmp && \
    wget https://repo1.maven.org/maven2/io/debezium/debezium-connector-postgres/${VERSION}/debezium-connector-postgres-${VERSION}-plugin.tar.gz && \
    tar -xvzf debezium-connector-postgres-${VERSION}-plugin.tar.gz

FROM quay.io/strimzi/kafka:0.43.0-kafka-3.8.0
USER root:root
COPY --from=builder /tmp/debezium-connector-postgres /opt/kafka/plugins/debezium-connector-postgres
USER 1001:1001
