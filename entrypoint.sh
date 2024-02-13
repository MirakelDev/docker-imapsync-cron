#!/bin/sh

env >> /etc/environment

# Run substitutions on the template file and inject the crontab
envsubst < /crontab.template > /etc/crontab

chmod +x /etc/crontab

# execute CMD
echo "$@"
exec "$@"
