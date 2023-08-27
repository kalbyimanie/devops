#!/usr/bin/env bash
GPG_HOME_PATH="/root/.gnupg/"

KEY_GENERATOR_CONFIG=$1
USE_EXISTING_KEY=$2

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

    case $USE_EXISTING_KEY in

        no)
            echo "generating new keys..."
            generate_keys $KEY_GENERATOR_CONFIG
        ;;

        yes)
            echo "skipping generating new keys..."
            cp -pfv /opt/.*.key /root
        ;;

        *)
            echo "RECOGNIZABLE ARG -> yes or no"
            exit 1
        ;;

    esac
}

main "$@"