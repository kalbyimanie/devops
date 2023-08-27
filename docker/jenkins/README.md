### [ localhost ] How to encrypt jenkins.env using gnupg

1. create a file called `jenkins.env` inside `docker/gnupg/data` directory
2. edit `jenkins.env` accordingly
3. go to `docker/jenkins` directory, then run the following command
`make setup-encryptor`

The above command will generate th following files under `docker/gnupg/data` directory :

- **.public.key**
- **.private.key**
- **jekins.env.enc**

### [ localhost ] How to decrypt jenkins.env using gnupg

1. go to `docker/jenkins` directory, then run the following command
`make setup-decryptor`

The above command will generate th following files under `docker/gnupg/data` directory :
- **jekins.env.dec**


### [ localhost ] Enable ngrok to test github webook on jenkins
