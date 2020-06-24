#! /bin/bash -w
# This presumes login data is stored in .mylogin.cnf,
# $MYSQL_HOST is set to the default mysql host
# & $PUSHBOX_DATABASE is the name of the containing database.
# If the PUSHBOX_DATABASE is not defined, this script will attempt
# to extract it from the `Rocket.toml` file.
if [ "$PUSHBOX_DATABASE" = "" ]; then
    echo "Fetching database..."
    PUSHBOX_DATABASE=`grep "^database_url" Rocket.toml | sed 's/"//g'| tr '/' "\n" | tail -1`
fi
mysql $PUSHBOX_DATABASE -e "DELETE FROM pushboxv1 WHERE ttl < unix_timestamp();"
