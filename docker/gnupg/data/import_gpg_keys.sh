#!/bin/bash
GPG_HOME_PATH="/root/.gnupg/"

import_keys() {
  gpg --pinentry-mode=loopback --batch --import /root/.*.key
}

main (){
  import_keys
}

main "$@"

