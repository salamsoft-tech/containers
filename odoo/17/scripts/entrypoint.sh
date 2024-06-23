#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

. /opt/scripts/env.sh

if [[ "$1" = "/opt/scripts/run.sh" ]]; then
    /opt/scripts/setup.sh
    echo "Odoo setup finish!"
fi

exec "$@"
