#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

############################
# Arguments:
#   $1 - template path
odoo_apply_config_template() {
    local -r template_path=$1

    j2 $template_path
}

############################
# Arguments:
#   $1 - with demo data
odoo_install() {
    echo "Installing Odoo"
    local -a init_args=("--stop-after-init" "--init=all")

    with_demo_data=${1:-no}

    if [[ $with_demo_data == "no" ]]; then
        init_args+=("--without-demo=all")
    fi

    odoo --config $ODOO_CONF_FILE ${init_args[@]}

    echo "Updating admin credentials"
    echo "UPDATE res_users SET login = '${ODOO_EMAIL}', password = '${ODOO_PASSWORD}' WHERE login = 'admin'" | \
    postgresql_exec \
        $ODOO_DATABASE_HOST \
        $ODOO_DATABASE_PORT \
        $ODOO_DATABASE_NAME \
        $ODOO_DATABASE_USER \
        $ODOO_DATABASE_PASSWORD
}
