#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

. /opt/scripts/env.sh

declare -a args=("--config" "$ODOO_CONF_FILE" "$@")

exec odoo "${args[@]}"
