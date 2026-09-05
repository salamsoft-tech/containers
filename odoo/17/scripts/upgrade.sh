#!/bin/bash

# Runs database migrations for changed modules, then exits. Meant to run as a
# one-shot Job (e.g. an Argo CD PreSync hook) BEFORE new application pods roll
# out, so they always start against an already-migrated schema. The regular
# entrypoint never upgrades modules (setup.sh only bootstraps an empty
# database), which otherwise leaves new code serving against an old schema
# until someone upgrades manually.

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

table_count=`echo "\dt res_partner" | postgresql_exec \
    $ODOO_DATABASE_HOST \
    $ODOO_DATABASE_PORT \
    $ODOO_DATABASE_NAME \
    $ODOO_DATABASE_USER \
    $ODOO_DATABASE_PASSWORD \
    | wc -l || echo ''`

if [[ $table_count = "1" ]]; then
    echo "Database not bootstrapped yet, nothing to upgrade"
    exit 0
fi

# click-odoo-update stores a checksum per module and only upgrades the ones
# whose code actually changed, so this is a fast no-op on syncs that don't
# touch addons.
echo "Upgrading changed modules"
exec click-odoo-update --config $ODOO_CONF_FILE
