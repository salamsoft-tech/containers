FROM docker.io/bitnami/odoo:17.0.20240605-debian-12-r0

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    nano \
    git \
  && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN /opt/bitnami/odoo/venv/bin/pip3 install \
    docxtpl \
    jinja2 \
    jwt \
    num2words

# Replace deprecated longpolling_port with gevent_port
RUN sed -i -E -e 's/longpolling_port/gevent_port/' /opt/bitnami/scripts/odoo/bitnami-templates/odoo.conf.tpl
