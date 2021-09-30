#!/bin/bash

set -e
NEXT_WAIT_TIME=0
COND=30
until [ $NEXT_WAIT_TIME -eq $COND ]; do
	c="mysqladmin ping -h database -u drupal -pdrupal"
#	if eval '$c' &> /dev/null; then echo 1; else echo 0; fi
	if eval '$c' &> /dev/null; then
		echo "Success!"
		break
	fi
	echo "Trying to connect, please wait... "
	sleep $(( NEXT_WAIT_TIME++ ))
	if [ $NEXT_WAIT_TIME -eq $COND ]; then
	  echo "Connection Attempt Timed Out!"
	fi
done

echo “O CMD é $@“
exec "$@"
