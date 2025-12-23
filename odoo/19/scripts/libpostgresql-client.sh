#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

############################
# Stdin:
#   Query to execute
# Arguments:
#   $1 - hostname
#   $2 - port
#   $3 - database
#   $4 - user
#   $5 - password
postgresql_exec() {
    local -a args=("--host" "$1" "--port" "$2" "--dbname" "$3" "--user" "$4")
    PGPASSWORD=$5 psql ${args[@]} &> /dev/stdout
}

############################
# Arguments:
#   $1 - hostname
#   $2 - port
#   $3 - database
#   $4 - user
#   $5 - password
#   $6 - retries
postgresql_check_connection() {
   local -r retries=${6:-5}
    local -r sleep_time=1

    f() {
        echo "SELECT 1" | postgresql_exec $1 $2 $3 $4 $5
    }

    local output=""
    local return_value=1
    for ((i = 1; i <= retries; i += 1)); do
        output=`f $1 $2 $3 $4 $5 &> /dev/stdout` && return_value=0 && break
        sleep "$sleep_time"
    done

    if [[ $return_value -ne "0" ]]; then
       echo $output
    fi


    return $return_value
}
