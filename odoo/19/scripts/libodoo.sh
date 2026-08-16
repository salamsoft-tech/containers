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
# Whether a value is truthy, case-insensitively
# Arguments:
#   $1 - value
odoo_is_true() {
    case "${1:-}" in
        [Tt][Rr][Uu][Ee] | [Yy][Ee][Ss] | [Oo][Nn] | 1) return 0 ;;
        *) return 1 ;;
    esac
}

############################
# Arguments:
#   $1 - with demo data
odoo_install() {
    echo "Installing Odoo"
    local -a init_args=("--stop-after-init" "--init=all")

    with_demo_data=${1:-no}

    # Since 19.0 demo data is opt-in: --with-demo is a flag and no demo data is
    # the default, replacing the module-list form of --without-demo
    if odoo_is_true "$with_demo_data"; then
        init_args+=("--with-demo")
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
