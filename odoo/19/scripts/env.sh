#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

export ODOO_DATABASE_PORT="${ODOO_PORT_NUMBER:-5432}"
export ODOO_CONF_TEMPLATE_FILE="/opt/scripts/odoo.conf.j2"
export ODOO_CONF_FILE="/etc/odoo/odoo.conf"
export ODOO_SERVER_WIDE_MODULES="${ODOO_SERVER_WIDE_MODULES:-base,web,kube_healthcheck}"
export ODOO_SKIP_BOOTSTRAP="${ODOO_SKIP_BOOTSTRAP:-false}"
export ODOO_LOAD_DEMO_DATA="${ODOO_LOAD_DEMO_DATA:-false}"
export ODOO_LIMIT_TIME_CPU="${ODOO_LIMIT_TIME_CPU:-600}"
export ODOO_LIMIT_TIME_REAL="${ODOO_LIMIT_TIME_REAL:-1200}"
export ODOO_WORKERS="${ODOO_WORKERS:-0}"
export ODOO_HTTP_INTERFACE="${ODOO_HTTP_INTERFACE:-0.0.0.0}"
export ODOO_EXTRA_ADDONS_PATH="${ODOO_EXTRA_ADDONS_PATH:-/mnt/extra-addons}"
#
export ODOO_EMAIL="${ODOO_EMAIL:-admin@example.com}"
export ODOO_PASSWORD="${ODOO_PASSWORD:-odooadmin}"
