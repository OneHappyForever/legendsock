#!/bin/sh
PATH=/bin:/sbin:$PATH

set -e

if [ "${1:0:1}" = '-' ]; then
    set -- python "$@"
fi

sed -i "s#"_DATABASE_"#"$MYSQL_DBNAME"#g" /usr/local/legendsock/usermysql.json;
sed -i "s#"_USERNAME_"#"$MYSQL_USER"#g" /usr/local/legendsock/usermysql.json;
sed -i "s#"_PASSWORD_"#"$MYSQL_PASSWORD"#g" /usr/local/legendsock/usermysql.json;
sed -i "s#"_HOSTNAME_"#"$MYSQL_HOST"#g" /usr/local/legendsock/usermysql.json;
sed -i "s#"_PORT_"#"$MYSQL_PORT"#g" /usr/local/legendsock/usermysql.json;

echo $DOCKER_DNS > /usr/local/legendsock/dns.conf

exec /usr/local/legendsock/start.sh
