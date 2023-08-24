### How to encrypt jenkins.env using gnupg

1. create jenkins.env inside `docker/gnupg/data` directory
2. edit `jenkins.env` accordingly
3. go to `docker/jenkins` directory, then run the following command
`make setup-encryptor`

The above command will generate th following files under `docker/gnupg/data` directory :

- **.public.key**
- **.private.key**
- **jenkins.env**
- **jekins.env.enc**

you can import .public.key and .private.key files using `gpg --pinentry-mode=loopback --batch --import .*.key` on your local laptop,

then to decrypt `jenkins.env.enc`, you can run the following command :

`decrypt_gpg_files.sh jenkins.env jenkins.env.enc generate-key-config.txt`

### How to decrypt jenkins.env using gnupg
