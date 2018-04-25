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

# Install Postfix
RUN apk add --no-cache postfix

#COPY files/* /etc/postfix/

CMD [ "/usr/lib/postfix/master" ]
