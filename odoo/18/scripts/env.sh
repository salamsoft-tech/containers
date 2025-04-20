#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

export ODOO_DATABASE_PORT="${ODOO_PORT_NUMBER:-5432}"
export ODOO_CONF_TEMPLATE_FILE="/opt/scripts/odoo.conf.j2"
export ODOO_CONF_FILE="/etc/odoo/odoo.conf"
export ODOO_SKIP_BOOTSTRAP="${ODOO_SKIP_BOOTSTRAP:-false}"
export ODOO_LOAD_DEMO_DATA="${ODOO_LOAD_DEMO_DATA:-false}"
#
export ODOO_EMAIL="${ODOO_EMAIL:-admin@example.com}"
export ODOO_PASSWORD="${ODOO_PASSWORD:-odooadmin}"
