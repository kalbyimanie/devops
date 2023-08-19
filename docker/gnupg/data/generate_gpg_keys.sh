#!/usr/bin/env bash
GPG_HOME_PATH="/root/.gnupg/"

KEY_GENERATOR_CONFIG=$1

generate_keys() {

    SECRET_KEY="/root/.secret.key"
    PUBLIC_KEY="/root/.public.key"

    echo -e "cleaning up key rings and gpg keys\n"
    rm -rf ~/.gnupg
    rm -f .*.key
    gpg --batch --full-generate-key $1

    RECIPIENT_EMAIL="$(grep -i "name-email" $1 |awk '-F:' '{print $2}'|sed '/^$/d')"

    PASSWORD="$(grep -i "passphrase" $1 |awk '-F:' '{print $2}'|sed '/^$/d')"

    touch $SECRET_KEY
    touch $PUBLIC_KEY

    echo $PASSWORD | gpg --batch --armor --export-secret-keys --pinentry-mode loopback --passphrase-fd 0 > $SECRET_KEY

    gpg --armor --export $RECIPIENT_EMAIL > $PUBLIC_KEY
}


main(){
    generate_keys $KEY_GENERATOR_CONFIG
}

main "$@"