#!/bin/bash
. /etc/openvpn/login/config.sh

if [ $# -ne 4 ]; then
    echo "invalid number of arguments"
    exit 1
fi

ADDR=$1
AUTH=$2
SEND=$3
RECV=$4

USERNAME=$(echo "$AUTH" | cut -d ":" -f 1)
PASSWORD=$(echo "$AUTH" | cut -d ":" -f 2)

Query="SELECT user_name FROM users WHERE user_name='$USERNAME' AND auth_vpn=md5('$PASSWORD') AND is_freeze='0' AND duration > 0"
username=`mysql -u $USER -p$PASS -D $DB -h $HOST -sN -e "$Query"`
[ "$username" != '' ] && [ "$username" = "$USERNAME" ] && echo "user : $username" && echo 'authentication ok.' && exit 0 || echo 'Authentication failed.'; exit 1