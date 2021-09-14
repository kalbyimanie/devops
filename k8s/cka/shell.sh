#!/usr/bin/env bash

while true; do
  TIMEOUT=3

  for (( INIT=0; INIT < $TIMEOUT; INIT++ ));do
    telnet $SERVICE_NAME $SERVICE_PORT
    sleep 2
  done
  echo "connection timeout: trying to connect to ${SERVICE_NAME} ${SERVICE_PORT}"
done
