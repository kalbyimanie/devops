#!/usr/bin/env bash
SERVICE_NAME=${SERVICE_NAME:-default}
SERVICE_PORT=${SERVICE_PORT:-default}


test_conn() {
  while true; do
    telnet $SERVICE_NAME $SERVICE_PORT
    sleep 2
    if [[ $? == 0 ]]; then
      sleep 2
      telnet $SERVICE_NAME $SERVICE_PORT
    fi
    if [[ $? != 0 ]]; then
      TIMEOUT=3
      for (( INIT=0; INIT < $TIMEOUT; INIT++ ));do
        telnet $SERVICE_NAME $SERVICE_PORT
        sleep 2
      done
      echo "!!! connection timeout: trying to connect to ${SERVICE_NAME}:${SERVICE_PORT} !!!"
    fi
  done
}

main(){
  if [[ -z $SERVICE_NAME ]] && [[ -z $SERVICE_PORT ]];then
    echo "required params SERVICE_NAME & SERVICE_PORT"
    exit 1
  else
    test_conn $SERVICE_NAME $SERVICE_PORT
  fi
}

main
