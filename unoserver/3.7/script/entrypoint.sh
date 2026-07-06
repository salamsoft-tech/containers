#!/bin/sh

set -e -u

echo "using: $(libreoffice --version)"

# unoserver defaults to 127.0.0.1; bind 0.0.0.0 so other containers can reach it
exec unoserver --interface 0.0.0.0 --port 2003
