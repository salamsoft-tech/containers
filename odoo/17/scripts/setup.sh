#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

. /opt/scripts/env.sh
. /opt/scripts/libpostgresql-client.sh
. /opt/scripts/libodoo.sh

echo "Checking database connection"
postgresql_check_connection \
    $ODOO_DATABASE_HOST \
    $ODOO_DATABASE_PORT \
    postgres \
    $ODOO_DATABASE_USER \
    $ODOO_DATABASE_PASSWORD \
    30

echo "Generating configuration file" 
odoo_apply_config_template $ODOO_CONF_TEMPLATE_FILE > $ODOO_CONF_FILE

if [[ $ODOO_SKIP_BOOTSTRAP == "false" ]]; then
    table_count=`echo "\dt res_partner" | postgresql_exec \
        $ODOO_DATABASE_HOST \
        $ODOO_DATABASE_PORT \
        $ODOO_DATABASE_NAME \
        $ODOO_DATABASE_USER \
        $ODOO_DATABASE_PASSWORD \
        | wc -l || echo ''`

    if [[ $table_count = "1" ]]; then
        odoo_install $ODOO_LOAD_DEMO_DATA
    fi
fi
