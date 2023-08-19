### How to encrypt jenkins.env using gnupg
1. create jenkins.env inside gnupg/data directory
2. edit jenkins.env
3. go to jenkins directory, then run the following command
`make setup-encryptor`

The above command will generate :
- .public.key
- .private.key
- jenkins.env
- jekins.env.enc

you can import .public.key and .private.key files using `gpg --pinentry-mode=loopback --batch --import .*.key` on your local laptop, then to decrypt <i>jenkins.env.enc</i>, you can run the following command :
`decrypt_gpg_files.sh jenkins.env jenkins.env.enc generate-key-config.txt`
