#!/usr/bin/env bash

JENKINS_DECRYPTED_FILE_PATH="../../gnupg/data"
JENKINS_DECRYPTED_FILE="$JENKINS_DECRYPTED_FILE_PATH/jenkins.env.dec"

DESTINATION_FILE_PATH="../casc-configs"
JENKINS_ENV_FILE="$DESTINATION_FILE_PATH/jenkins.env"

if [[ ! -f "$JENKINS_DECRYPTED_FILE" ]];then
    echo -en "ERROR: $JENKINS_DECRYPTED_FILE does not exist\n"
    echo -en "Please prepare the file\n"

    exit 1
fi
echo -ne "Copying jenkins env file...\n"
# cd $DESTINATION_FILE_PATH
cp -pv $JENKINS_DECRYPTED_FILE $JENKINS_ENV_FILE