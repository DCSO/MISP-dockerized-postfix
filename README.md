# Supported tags and respective `Dockerfile` links

- [`1.0.0-alpine`, `1.0.0`, `latest`][1]

[1]: https://github.com/DCSO/MISP-dockerized-postfix/blob/master/1.0.0-alpine/Dockerfile

# Quick reference

-	**Where to file issues**:  
	[https://github.com/DCSO/MISP-dockerized-postfix/issues](https://github.com/DCSO/MISP-dockerized-postfix/issues)

-	**Maintained by**:  
	[DCSO](https://github.com/DCSO)

-	**Supported Docker versions**:  
	[the latest release](https://github.com/docker/docker-ce/releases/latest)

# What is MISP dockerized?

**MISP dockerized** is a project designed to provide an easy-to-use and easy-to-install'out of the box' MISP instance that includes everything you need to run MISP with minimal host-side requirements. 

**MISP dockerized** uses MISP (Open Source Threat Intelligence Platform - https://github.com/MISP/MISP), which is maintend and developed by the MISP project team (https://www.misp-project.org/)

### Project Information

| | |
|-|-|
| Travis Master | [![][101]][102] |
| Docker Size & Layers | [![][104]][107]|
| Latest Docker Version | [![][105]][107]|
| Commit for Latest Docker Version | [![][106]][107]|

[101]: https://travis-ci.org/DCSO/MISP-dockerized-postfix.svg?branch=master
[102]: https://travis-ci.org/DCSO/MISP-dockerized-postfix
[104]: https://images.microbadger.com/badges/image/dcso/misp-postfix.svg
[105]: https://images.microbadger.com/badges/version/dcso/misp-postfix.svg
[106]: https://images.microbadger.com/badges/commit/dcso/misp-postfix.svg
[107]: https://microbadger.com/images/dcso/misp-postfix




# How to use this image

## Usage

For the Usage please read the [MISP-dockerized](https://github.com/DCSO/MISP-dockerized) Github Repository.

### Environment Variables

| Variable | Default Value | Description|
|---|---|---|
HOSTNAME|misp|Hostname for the Mailserver | 
|DOMAIN|example.com| Domain for Outgoing Mail |
|SENDER_ADDRESS|admin@example.com|Sender for local postfix outgoing Mails|
|RELAYHOST|smtp.example.com:587|Relahost to Send Mails|
|RELAY_USER|misp|Username for the authentication on the Relayhost|
|RELAY_PASSWORD|ChangeMe| Password for the authentication on the Relayhost|
|DOCKER_NETWORK|192.168.47.0/28|Restrict access to postfix to this IP-range|
|DEBUG_PEER|none| If you need debugging log for a specified host set this to the domain, FQDN or ip address|

### Using with docker-compose
``` bash
services:
  ### Postfix ###
  misp-postfix:
    image: dcso/misp-dockerized-postfix:${POSTFIX_CONTAINER_TAG}
    container_name: misp-postfix
    restart: on-failure
    environment:
      HOSTNAME: ${HOSTNAME}
      DOMAIN: ${DOMAIN}
      SENDER_ADDRESS: ${SENDER_ADDRESS}
      RELAYHOST: ${RELAYHOST}
      RELAY_USER: ${RELAY_USER}
      RELAY_PASSWORD: ${RELAY_PASSWORD}
      DOCKER_NETWORK: ${DOCKER_NETWORK}
      DEBUG_PEER: ${DEBUG_PEER}
    networks:
      misp-backend:
        aliases:
          - misp-postfix

```

#### .env file for docker-compose variable
If you want to use the postfix container with variables you require a .env file with the following content:
``` bash
#=================================================
# ------------------------------
# Hostname
# ------------------------------
HOSTNAME=misp.example.com
# ------------------------------
# Network Configuration
# ------------------------------
DOCKER_NETWORK="192.168.47.0/28"
BRIDGE_NAME="mispbr0"
# ------------------------------
# Container Configuration
# ------------------------------
POSTFIX_CONTAINER_TAG=1.0.0-alpine-dev
# ------------------------------
# Postfix Configuration
# ------------------------------
DOMAIN=example.com
RELAYHOST=mail.example.com
RELAY_USER=MrDQQUHXeg
RELAY_PASSWORD=g093bJljQUhLzgwK2LYIE77UUGIS
SENDER_ADDRESS=admin@misp.example.com
QUESTION_DEBUG_PEERS=no
DEBUG_PEER=none
##################################################################
```

### Usign with `docker run`
``` bash
docker run \
    --name misp-postfix \
    -e HOSTNAME: ${HOSTNAME} \
    -e DOMAIN: ${DOMAIN} \
    -e SENDER_ADDRESS: ${SENDER_ADDRESS} \
    -e RELAYHOST: ${RELAYHOST} \
    -e RELAY_USER: ${RELAY_USER} \
    -e RELAY_PASSWORD: ${RELAY_PASSWORD} \
    -e  DOCKER_NETWORK: ${DOCKER_NETWORK} \
    -e  DEBUG_PEER: ${DEBUG_PEER} \
    image: dcso/misp-dockerized-postfix
    
    
```


## Documentation
You can also find the [docker file](https://github.com/DCSO/MISP-dockerized-postfix/) at Github.


# License

View [license information](https://github.com/DCSO/MISP-dockerized-proxy/blob/master/LICENSE) for the software contained in this image.

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.

# Contributions

We would say thanks to maker of:
- Mailu
- Mailcow

We have oriented on their docker container to build our ones.