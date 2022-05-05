FROM eclipse-temurin:17-jdk-focal as builder

ENV GLASSFISH_VERSION=6.2.5

RUN apt-get update \
 && apt-get install --no-install-recommends -y unzip \
 && apt-get clean  \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /opt

ADD "https://download.eclipse.org/ee4j/glassfish/glassfish-$GLASSFISH_VERSION.zip" /opt/
RUN unzip glassfish-$GLASSFISH_VERSION.zip

FROM eclipse-temurin:17-jdk-focal
LABEL maintainer="Ivo Woltring, ivonet.nl" description="Glassfish 6 Server Full"

ARG PASSWORD
ENV GLASSFISH_ARCHIVE glassfish
ENV DOMAIN_NAME domain1
ENV INSTALL_DIR /opt
ENV GLASSFISH_HOME ${INSTALL_DIR}/glassfish6
ENV DEPLOY_DIR ${GLASSFISH_HOME}/${GLASSFISH_ARCHIVE}/domains/${DOMAIN_NAME}/autodeploy
ENV PATH="${GLASSFISH_HOME}/${GLASSFISH_ARCHIVE}/bin:$PATH"
ENV USR glassfish

RUN useradd -b /opt -m -s /bin/sh -d ${GLASSFISH_HOME} ${USR} \
 && echo "root:${PASSWORD:-secret}" | chpasswd \
 && echo ${USR}:${USR} | chpasswd

WORKDIR ${GLASSFISH_HOME}
COPY --from=builder /opt/glassfish6 ${GLASSFISH_HOME}
COPY entrypoint.sh /entrypoint.sh

RUN mkdir -p "${DEPLOY_DIR}" \
 && chown -R ${USR}:${USR} ${GLASSFISH_HOME} \
 && chmod +x /entrypoint.sh

USER ${USR}
VOLUME ["${DEPLOY_DIR}"]

EXPOSE 8080 4848
ENTRYPOINT ["/entrypoint.sh"]
CMD ["asadmin", "start-domain", "--verbose"]
