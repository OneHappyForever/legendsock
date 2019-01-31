#!/bin/sh
PATH=/bin:/sbin:$PATH

set -e

if [ "${1:0:1}" = '-' ]; then
    set -- python "$@"
fi

sed -i "s#"_DATABASE_"#"$MYSQL_DBNAME"#g" /legendsock/usermysql.json;
sed -i "s#"_USERNAME_"#"$MYSQL_USER"#g" /legendsock/usermysql.json;
sed -i "s#"_PASSWORD_"#"$MYSQL_PASSWORD"#g" /legendsock/usermysql.json;
sed -i "s#"_HOSTNAME_"#"$MYSQL_HOST"#g" /legendsock/usermysql.json;
sed -i "s#"_PORT_"#"$MYSQL_PORT"#g" /legendsock/usermysql.json;

echo $DOCKER_DNS > /legendsock/dns.conf

exec python /legendsock/server.py m
