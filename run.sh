#!/bin/sh

NB_CREATION=1
if [[ ! -z "$1" ]]
then
  NB_CREATION=$1
fi

PAYLOAD_AUTH='{
	"username":"saitama",
	"password":"toor"
}'

# Authentification
URL_AUTH="YOUR URL AUTH"
RESPONSE_AUTH=`curl -s --request POST -H "Content-Type:application/json" -H POST "${URL_AUTH}" --data "${PAYLOAD_AUTH}"`


# GET TOKEN FROM AUTH
TOKEN_AUTH=$(echo $RESPONSE_AUTH | sed "s/{.*\"token\":\"\([^\"]*\).*}/\1/g")

if [ $TOKEN_AUTH = "{}" ]
then
  echo "ECHEC Authentification"
  exit
fi

# LOOP POST URL
URL_POST='YOUR POST HTTP URL'

for i in $(seq 1 $NB_CREATION)
do
  RAND_KEY=$(( RANDOM % (111111111111 - 999999999999 + 1 ) + 99999999999 ))
  PAYLOAD='{
    "foo" : "'${RAND_KEY}'",
    "bar" : "201",
    "faa" : "L"
  }'

  RESPONSE=`curl -s --request POST -H "Content-Type:application/json" -H "Authorization: Bearer "${TOKEN_AUTH}"" POST "${URL_POST}" --data "${PAYLOAD}"`

  echo $RESPONSE
done
