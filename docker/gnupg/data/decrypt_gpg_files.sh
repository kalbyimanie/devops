#!/bin/bash
GPG_HOME_PATH="/root/.gnupg/"

KEY_GENERATOR_CONFIG=$1
OUTPUT_DECRYPTED_FILE=$2
INPUT_ENCRYPTED_FILE=$3

decrypt_file() {
  PASSPHRASE="$(grep -i "passphrase" $1 |awk '-F:' '{print $2}'|sed '/^$/d')"
  gpg --pinentry-mode=loopback --batch --passphrase $PASSPHRASE --output $2 --decrypt $3
}

import_keys() {
  gpg --pinentry-mode=loopback --batch --import .*.key
}



main(){

  import_keys
  decrypt_file $KEY_GENERATOR_CONFIG $OUTPUT_DECRYPTED_FILE $INPUT_ENCRYPTED_FILE
}

main "$@"