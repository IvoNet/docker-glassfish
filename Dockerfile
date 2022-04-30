FROM eclipse-temurin:11-jdk-focal as builder

ENV GLASSFISH_VERSION=6.2.5

RUN apt-get update \
 && apt-get install --no-install-recommends -y wget unzip \
 && apt-get clean  \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /opt

RUN wget -q https://download.eclipse.org/ee4j/glassfish/glassfish-$GLASSFISH_VERSION.zip \
 && unzip glassfish-$GLASSFISH_VERSION.zip


FROM eclipse-temurin:11-jdk-focal

LABEL maintainer="Ivo Woltring, ivonet.nl" description="Glassfish 6 Server Full"
ARG PASSWORD
ENV GLASSFISH_ARCHIVE glassfish
ENV DOMAIN_NAME domain1
ENV INSTALL_DIR /opt
ENV GLASSFISH_HOME ${INSTALL_DIR}/glassfish6
ENV DEPLOY_DIR ${GLASSFISH_HOME}/${GLASSFISH_ARCHIVE}/domains/${DOMAIN_NAME}/autodeploy
ENV PATH="${GLASSFISH_HOME}/${GLASSFISH_ARCHIVE}/bin:$PATH"
ENV AS_ADMIN_NEWPASSWORD ${PASSWORD:-secret}
ENV USR glassfish

RUN useradd -b /opt -m -s /bin/sh -d ${GLASSFISH_HOME} ${USR} \
 && echo "root:$AS_ADMIN_NEWPASSWORD" | chpasswd \
 && echo ${USR}:${USR} | chpasswd

WORKDIR ${GLASSFISH_HOME}
COPY --from=builder /opt/glassfish6 ${GLASSFISH_HOME}

RUN chown -R ${USR}:${USR} ${GLASSFISH_HOME}

USER ${USR}

RUN asadmin start-domain -d \
 && echo "AS_ADMIN_PASSWORD=">pwd.txt \
 && echo "AS_ADMIN_NEWPASSWORD=${AS_ADMIN_NEWPASSWORD}">>pwd.txt \
 && cat pwd.txt \
 && asadmin --host localhost --port 4848 --user admin --passwordfile pwd.txt change-admin-password \
 && echo "AS_ADMIN_PASSWORD=${AS_ADMIN_NEWPASSWORD}">pwd.txt \
 && cat pwd.txt \
 && asadmin --host localhost --port 4848 --user admin --passwordfile pwd.txt enable-secure-admin \
 && asadmin --host localhost --port 4848 --user admin --passwordfile pwd.txt set configs.config.default-config.admin-service.jmx-connector.system.address=127.0.0.1 \
 && asadmin --host localhost --port 4848 --user admin --passwordfile pwd.txt set configs.config.default-config.admin-service.jmx-connector.system.security-enabled=false \
 && rm -f pwd.txt \
 && asadmin stop-domain

VOLUME ["${DEPLOY_DIR}"]

EXPOSE 8080 4848

ENTRYPOINT ["asadmin", "start-domain", "--verbose"]
