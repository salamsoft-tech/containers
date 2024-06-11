FROM docker.io/bitnami/odoo:17.0.20240605-debian-12-r0

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    nano \
    git \
  && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN /opt/bitnami/odoo/venv/bin/pip3 install \
    docxtpl \
    jwt
