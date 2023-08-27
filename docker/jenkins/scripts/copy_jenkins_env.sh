#!/usr/bin/env bash

JENKINS_DECRYPTED_FILE_PATH="../../gnupg/data"
JENKINS_DECRYPTED_FILE="$JENKINS_DECRYPTED_FILE_PATH/jenkins.env.dec"

DESTINATION_FILE_PATH="../casc-configs"
JENKINS_ENV_FILE="$DESTINATION_FILE_PATH/jenkins.env"

FLAG=""

if [[ -f "$JENKINS_ENV_FILE" ]]; then
    FLAG="exists"
fi

case "$FLAG" in
    exists)
        echo "Using existing jenkins env file"
    ;;

    *)
        if [[ ! -f "$JENKINS_DECRYPTED_FILE" ]];then
            echo -en "ERROR: $JENKINS_DECRYPTED_FILE file does not exist\n"
            echo -en "Please prepare the file\n"

            exit 1
        fi
        echo -ne "Copying jenkins env file from $JENKINS_DECRYPTED_FILE...\n"
        cp -pv $JENKINS_DECRYPTED_FILE $JENKINS_ENV_FILE
    ;;
esac

