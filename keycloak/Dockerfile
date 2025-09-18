FROM alpine/git:latest AS sources
WORKDIR /src
RUN git clone https://github.com/mitodl/ol-keycloak.git

FROM maven:3-eclipse-temurin-21 AS build-mvn

COPY --from=sources /src/ol-keycloak /src/ol-keycloak
RUN cd /src/ol-keycloak/ol-keycloak/oltheme && mvn clean install
RUN cd /src/ol-keycloak/ol-keycloak/ol-spi && mvn clean install

FROM gradle:8-jdk21-alpine AS build-gradle

ADD ../repos/keycloak-scim/ /src/keycloak-scim
RUN cd /src/keycloak-scim && gradle clean shadowJar

# -------------------------------------------------------------------------
FROM registry.access.redhat.com/ubi9 AS ubi-micro-build
ARG packages="curl dnsutils"
RUN mkdir -p /mnt/rootfs
RUN dnf install --installroot /mnt/rootfs ${packages} --releasever 9 --setopt install_weak_deps=false --nodocs -y && \
    dnf --installroot /mnt/rootfs clean all && \
    rpm --root /mnt/rootfs -e --nodeps setup

# -------------------------------------------------------------------------
FROM quay.io/keycloak/keycloak:26.2.4
COPY --from=ubi-micro-build /mnt/rootfs /

# COPY --from=build-gradle /src/keycloak-scim/build/libs/*.jar /opt/keycloak/providers/
ADD ./providers/*.jar /opt/keycloak/providers/
COPY --from=build-mvn /src/ol-keycloak/ol-keycloak/oltheme/target/*.jar /opt/keycloak/providers/
COPY --from=build-mvn /src/ol-keycloak/ol-keycloak/ol-spi/target/*.jar /opt/keycloak/providers/

