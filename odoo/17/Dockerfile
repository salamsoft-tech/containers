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

RUN mkdir -p /opt/oca-addons && cd /opt/oca-addons && \
  OCA_REPOS=( \
    hr \
    partner-contact \
    reporting-engine \
    server-auth \
    server-backend \
    server-tools \
    server-ux \
    web \
  ) && \
  for REPO in "${OCA_REPOS[@]}"; do \
    git clone --depth 1 --branch 17.0 https://github.com/OCA/${REPO}.git && \
    mv `find ${REPO} -type f -name '__manifest__.py' -exec dirname {} \;` . && \
    rm -r ${REPO} ; \
  done
RUN sed -i -E -e 's#(addons_path.+)#\1,/opt/oca-addons#' /opt/bitnami/scripts/odoo/bitnami-templates/odoo.conf.tpl

# Replace deprecated longpolling_port with gevent_port
RUN sed -i -E -e 's/longpolling_port/gevent_port/' /opt/bitnami/scripts/odoo/bitnami-templates/odoo.conf.tpl
