FROM maven:3-eclipse-temurin-11 as build-mvn

ADD ./repos/ol-keycloak/ /src/ol-keycloak
RUN cd /src/ol-keycloak/ol-keycloak/oltheme && mvn clean build
RUN cd /src/ol-keycloak/ol-keycloak/ol-spi && mvn clean build

FROM gradle:8-jdk17-alpine as build-gradle

ADD ./repos/keycloak-scim/ /src/keycloak-scim
RUN cd /src/keycloak-scim && gradle clean shadowJar

# -------------------------------------------------------------------------
FROM quay.io/keycloak/keycloak:24.0
COPY --from=build-gradle /src/keycloak-scim/build/*.jar /opt/keycloak/providers/
COPY --from=build-mvn /src/ol-keycloak/ol-keycloak/oltheme/target/*.jar /opt/keycloak/providers/
COPY --from=build-mvn /src/ol-keycloak/ol-keycloak/ol-spi/target/*.jar /opt/keycloak/providers/

