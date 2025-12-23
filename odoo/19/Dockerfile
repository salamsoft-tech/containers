FROM ubuntu:noble-20251013

SHELL ["/bin/bash", "-xo", "pipefail", "-c"]

RUN apt-get update && \
    apt-get install -y locales && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG=en_US.UTF-8

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        postgresql-common \
        ca-certificates \
        curl \
        git \
        j2cli \
        nano \
        unzip && \
    rm -rf /var/lib/apt/lists/*

# Install PostgreSQL client
RUN /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh -y && \
    apt-get install -y --no-install-recommends postgresql-client-18 && \
    rm -rf /var/lib/apt/lists/*

# Install Node
ENV NODE_VERSION=24
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

ENV WKHTMLTOPDF_REPO=https://github.com/wkhtmltopdf/packaging
ARG TARGETARCH
RUN apt-get update && \
    apt-get install -y  --no-install-recommends \
        python3-pip \
        python3-lxml-html-clean && \
    if [ -z "${TARGETARCH}" ]; then \
        TARGETARCH="$(dpkg --print-architecture)"; \
    fi; \
    WKHTMLTOPDF_ARCH=${TARGETARCH} && \
    curl -sSL ${WKHTMLTOPDF_REPO}/releases/download/0.12.6.1-3/wkhtmltox_0.12.6.1-3.jammy_${WKHTMLTOPDF_ARCH}.deb \
        -o wkhtmltox.deb && \
    apt-get install -y --no-install-recommends ./wkhtmltox.deb &&\
    rm -rf /var/lib/apt/lists/* wkhtmltox.deb

ENV ODOO_VERSION=19.0
ARG ODOO_RELEASE=20251208
RUN curl -o odoo.deb -sSL http://nightly.odoo.com/${ODOO_VERSION}/nightly/deb/odoo_${ODOO_VERSION}.${ODOO_RELEASE}_all.deb && \
    apt-get update && \
    apt-get -y install --no-install-recommends ./odoo.deb && \
    rm -rf /var/lib/apt/lists/* odoo.deb

RUN pip3 install --upgrade --break-system-packages \
    docxtpl \
    jwt \
    openpyxl \
    phonenumbers

RUN mkdir -p /opt/oca-addons && cd /opt/oca-addons && \
    OCA_REPOS=( \
        account-financial-tools \
        currency \
        hr \
        partner-contact \
        payroll \
        reporting-engine \
        server-auth \
        server-backend \
        server-tools \
        server-ux \
        web \
    ) && \
    for REPO in "${OCA_REPOS[@]}"; do \
        repo_dir=`mktemp -d` && \
        git clone --depth 1 --branch ${ODOO_VERSION} https://github.com/OCA/${REPO}.git ${repo_dir} && \
        mv `find ${repo_dir} -type f -name '__manifest__.py' -exec dirname {} \;` . && \
        rm -r ${repo_dir} ; \
    done

RUN mkdir /opt/bundle-addons

COPY addons /opt/bundle-addons

ENTRYPOINT ["/opt/scripts/entrypoint.sh"]
CMD ["/opt/scripts/run.sh"]

COPY scripts/ /opt/scripts/

EXPOSE 8069 8072
VOLUME ["/var/lib/odoo", "/mnt/extra-addons"]
