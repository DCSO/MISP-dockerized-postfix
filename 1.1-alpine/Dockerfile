FROM alpine

#     Variables for Labels:
ARG VENDOR="DCSO GmbH"
ARG COMPONENT="postfix"
ARG BUILD_DATE
ARG GIT_REPO
ARG VCS_REF
ARG VERSION
ARG NAME="MISP-dockerized-${COMPONENT}"
ARG DESCRIPTION="This docker container is part of the DCSO MISP dockerized environment."
ARG DOCUMENTATION="https://github.com/DCSO/MISP-dockerized"
ARG AUTHOR="DCSO MISP Docker Team <misp.docker@dcso.de>"
ARG LICENSE="BSD-3-Clause"
#     END Variables

#########################################
LABEL org.label-schema.build-date="${BUILD_DATE}" \
        org.label-schema.name="${NAME}" \
        org.label-schema.description="${DESCRIPTION}" \
        org.label-schema.vcs-ref="${VCS_REF}" \
        org.label-schema.vcs-url="${GIT_REPO}" \
        org.label-schema.url="${GIT_REPO}" \
        org.label-schema.vendor="${VENDOR}" \
        org.label-schema.version="${VERSION}" \
        org.label-schema.usage="${DOCUMENTATION}" \
        org.label-schema.schema-version="1.0.0-rc1"

LABEL   org.opencontainers.image.created="${BUILD_DATE}" \
        org.opencontainers.image.url="${GIT_REPO}" \
        org.opencontainers.image.source="${GIT_REPO}" \
        org.opencontainers.image.version="${VERSION}" \
        org.opencontainers.image.revision="${VCS_REF}" \
        org.opencontainers.image.vendor="${VENDOR}" \
        org.opencontainers.image.title="${NAME}" \
        org.opencontainers.image.description="${DESCRIPTION}" \
        org.opencontainers.image.documentation="${DOCUMENTATION}" \
        org.opencontainers.image.authors="${AUTHOR}" \
        org.opencontainers.image.licenses="${LICENSE}"
#########################################

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
# Version + Name
ENV NAME ${NAME}
ENV VERSION ${VERSION}

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
