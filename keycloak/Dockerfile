FROM maven:3-eclipse-temurin-21 AS build-mvn

ADD ./repos/ol-keycloak/ /src/ol-keycloak
RUN cd /src/ol-keycloak/ol-keycloak/oltheme && mvn clean install
RUN cd /src/ol-keycloak/ol-keycloak/ol-spi && mvn clean install

FROM gradle:8-jdk21-alpine AS build-gradle

ADD ./repos/keycloak-scim/ /src/keycloak-scim
RUN cd /src/keycloak-scim && gradle clean shadowJar

# -------------------------------------------------------------------------
FROM registry.access.redhat.com/ubi9 AS ubi-micro-build
RUN mkdir -p /mnt/rootfs
RUN dnf install --installroot /mnt/rootfs curl --releasever 9 --setopt install_weak_deps=false --nodocs -y && \
    dnf --installroot /mnt/rootfs clean all && \
    rpm --root /mnt/rootfs -e --nodeps setup

# -------------------------------------------------------------------------
FROM quay.io/keycloak/keycloak:26.0.5
COPY --from=ubi-micro-build /mnt/rootfs /

# COPY --from=build-gradle /src/keycloak-scim/build/libs/*.jar /opt/keycloak/providers/
ADD ./keycloak/providers/*.jar /opt/keycloak/providers/
COPY --from=build-mvn /src/ol-keycloak/ol-keycloak/oltheme/target/*.jar /opt/keycloak/providers/
COPY --from=build-mvn /src/ol-keycloak/ol-keycloak/ol-spi/target/*.jar /opt/keycloak/providers/


