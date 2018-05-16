FROM alpine

#     Variables:
# for Labels:
ARG VENDOR="DCSO GmbH <www.dcso.de>"
ARG RELEASE_DATE
ARG IS_PRODUCTION="false"
ARG MAINTAINER="DCSO MISP <misp@dcso.de>"
ARG BUILD_DATE
ARG NAME=
ARG GIT_REPO
ARG VCS_REF
ARG VERSION
#     END Variables

#LABEL de.dcso.misp-server.version="0.0.1-alpha"
LABEL vendor=${VENDOR}
LABEL de.dcso.misp-server.release-date=${RELEASE_DATE}
LABEL de.dcso.misp-server.is-production=${IS_PRODUCTION}
LABEL maintainer=${MAINTAINER}
LABEL org.label-schema.build-date="${BUILD_DATE}" \
          org.label-schema.name="MISP-dockerized ${NAME}" \
          org.label-schema.description="This docker container is part of the DCSO MISP dockerized environment." \
          org.label-schema.vcs-ref="${VCS_REF}" \
          org.label-schema.vcs-url="${GIT_REPO}" \
          org.label-schema.vendor="${VENDOR}" \
          org.label-schema.version="${VERSION}" \
          org.label-schema.schema-version="1.0.0-rc1"

# Install Packages
RUN apk add --no-cache \
    postfix \
    mailx \
    libsasl \
    ca-certificates \
    syslog-ng \
    supervisor

# Hostname for the Mailserver
ENV HOSTNAME=misp
# Domain for Outgoing Mail
ENV DOMAIN=example.com
# Sender for local postfix outgoing Mails
ENV SENDER_ADDRESS=admin@example.com
# Relahost to Send Mails
ENV RELAYHOST=smtp.example.com:587
# RELAY User and Password
ENV RELAY_USER=misp
ENV RELAY_PASSWORD=ChangeMe
# Allow only MISP Docker Container Access
ENV DOCKER_NETWORK=192.168.47.0/28
# You need to get more postfix output for a specified host normally the relayhost or misp-server
ENV DEBUG_PEER=none


# Copy files to postfix container
COPY \
    files/main.cf* \
    file/master.cf* \
    files/smtp_auth \
    files/generic_misp \
        /etc/postfix/
COPY files/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
COPY files/supervisord.conf /etc/supervisor/supervisord.conf
COPY files/entrypoint.sh /

# make entrypoint.sh executable for supervisord:
RUN chmod +x /entrypoint.sh

# Execute Supervisod after start:
CMD exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
