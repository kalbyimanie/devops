#!/bin/bash
GPG_HOME_PATH="/root/.gnupg/"

KEY_GENERATOR_CONFIG=$1
OUTPUT_ENCRYPTED_FILE=$2
PLAIN_TEXT_FILE=$3

encrypt_file() {
    echo -e "cleaning up encrypted files\n"
    rm -f *.enc

    if [[ ! -f $3 ]];then
        echo "creating file $3..."
        touch $3
    fi

    KEY="$(gpg --list-keys|grep -i -m1 -A1 "^pub"|grep -vi '.*expire.*\|.*rsa2048.*'|tr -d '\ ')"

    PASSWORD="$(grep -i "passphrase" $1 |awk '-F:' '{print $2}'|sed '/^$/d')"

    gpg --pinentry-mode=loopback --batch --passphrase "'$PASSWORD'" --encrypt -r $KEY -o "$2" "$3"
}

copy_gpg_keys() {
    echo "cleaning up gpg keys..."
    rm -f .*.key
    echo -ne "Copying gpg keys to workdir..."
    cp -pv /root/.*.key /data
}

main(){
    encrypt_file "$KEY_GENERATOR_CONFIG" "$OUTPUT_ENCRYPTED_FILE" "$PLAIN_TEXT_FILE"

    copy_gpg_keys
}

main "$@"