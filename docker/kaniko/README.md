### How to build docker image using kaniko

#### Prerequisites
You need to setup the following before proceeding :
- Docker (for mac you can install and use docker-desktop <https://docs.docker.com/desktop/install/mac-install/>)
- Setup Local Repository using the following command :

```
docker run -d -p 5000:5000 --name registry registry:2.7
```

- Make sure that the local registry is running

Here are the following steps to build docker image using kaniko container.

#### CLI Build Image Format :
```
docker run \
-v .:<container_dir_path> \
--network="host" \
gcr.io/kaniko-project/executor:latest \
--context=<container_dir_path> --dockerfile=<container_dir_path>/<Dockerfile> \
--no-push
```

#### CLI Flags Explanation :
```
-v .:<container_dir_path> -> mounting current working directory on the host path to container path

--network="host" -> using host network

--context=<container_dir_path>  -> assign docker context to the directory of where the dockerfile is located

--dockerfile=<container_dir_path>/<Dockerfile> -> path to the Dockerfile
```

Example :
```
docker run \
-v .:/opt \
--network="host" \
gcr.io/kaniko-project/executor:latest \
--context=/opt --dockerfile=/opt/kaniko.Dockerfile \
--no-push
```
Example successful output :
```
docker run \
-v .:/opt \
--network="host" \
gcr.io/kaniko-project/executor:latest \
--context=/opt --dockerfile=/opt/kaniko.Dockerfile \
--no-push

INFO[0000] Retrieving image manifest ubuntu:latest
INFO[0000] Retrieving image ubuntu:latest from registry index.docker.io
INFO[0002] Built cross stage deps: map[]
INFO[0002] Retrieving image manifest ubuntu:latest
INFO[0002] Returning cached image manifest
INFO[0002] Executing 0 build triggers
INFO[0002] Building stage 'ubuntu:latest' [idx: '0', base-idx: '-1']
INFO[0002] Skipping unpacking as no commands require it.
INFO[0002] CMD ["/bin/bash", "-c", "tail -f /var/log/messages"]
INFO[0002] Skipping push to container registry due to --no-push flag
```

### How to build & push docker image to local repository
Here are the following steps to build & push docker image using kaniko container.

#### CLI Build Image Format

```
docker run \
-v .:<container_dir_path> \
--network="host" \
gcr.io/kaniko-project/executor:latest \
--context=/opt --dockerfile=<container_dir_path>/<Dockerfile> \
--destination=localhost:5000/<image_name>:<image_tag> \
--verbosity=debug \
--cache=true
```

#### CLI Flags Explanation :

```
-v .:<container_dir_path> -> mounting current working directory on the host path to container path

--network="host" -> using host network

--context=<container_dir_path>  -> assign docker context to the directory of where the dockerfile is located

--dockerfile=<container_dir_path>/<Dockerfile> -> path to the Dockerfile

--destination=localhost:5000/<image_name>:<image_tag> -> image tagging format to push to the local repository

--verbosity=debug -> verbosity level

--cache=true -> set to true to use build cache
```
Example :
```
docker run \
-v .:/opt \
--network="host" \
gcr.io/kaniko-project/executor:latest \
--context=/opt --dockerfile=/opt/kaniko.Dockerfile \
--destination=localhost:5000/ubuntu-from-kaniko:v3 \
--verbosity=debug \
--cache=true
```
Example successful output :
```
docker run \
-v .:/opt \
--network="host" \
gcr.io/kaniko-project/executor:latest \
--context=/opt --dockerfile=/opt/kaniko.Dockerfile \
--destination=localhost:5000/ubuntu-from-kaniko:v3 \
--verbosity=debug \
--cache=true

DEBU[0000] Copying file /opt/kaniko.Dockerfile to /kaniko/Dockerfile
DEBU[0000] Skip resolving path /kaniko/Dockerfile
DEBU[0000] Skip resolving path /opt
DEBU[0000] Skip resolving path /cache
DEBU[0000] Skip resolving path
DEBU[0000] Skip resolving path
DEBU[0000] Skip resolving path
DEBU[0000] Skip resolving path
DEBU[0000] Built stage name to index map: map[]
INFO[0000] Retrieving image manifest ubuntu:latest
INFO[0000] Retrieving image ubuntu:latest from registry index.docker.io
DEBU[0002] No file found for cache key sha256:02410fbfad7f2842cce3cf7655828424f4f7f6b5105b0016e24f1676f3bd15f5 stat /cache/sha256:02410fbfad7f2842cce3cf7655828424f4f7f6b5105b0016e24f1676f3bd15f5: no such file or directory
DEBU[0002] Image ubuntu:latest not found in cache
INFO[0002] Retrieving image manifest ubuntu:latest
INFO[0002] Returning cached image manifest
INFO[0002] Built cross stage deps: map[]
INFO[0002] Retrieving image manifest ubuntu:latest
INFO[0002] Returning cached image manifest
DEBU[0002] No file found for cache key sha256:02410fbfad7f2842cce3cf7655828424f4f7f6b5105b0016e24f1676f3bd15f5 stat /cache/sha256:02410fbfad7f2842cce3cf7655828424f4f7f6b5105b0016e24f1676f3bd15f5: no such file or directory
DEBU[0002] Image ubuntu:latest not found in cache
INFO[0002] Retrieving image manifest ubuntu:latest
INFO[0002] Returning cached image manifest
INFO[0002] Executing 0 build triggers
INFO[0002] Building stage 'ubuntu:latest' [idx: '0', base-idx: '-1']
DEBU[0002] Optimize: composite key for command CMD ["/bin/bash", "-c", "tail -f /var/log/messages"] {[sha256:02410fbfad7f2842cce3cf7655828424f4f7f6b5105b0016e24f1676f3bd15f5 CMD [/bin/bash, -c, tail -f /var/log/messages]]}
DEBU[0002] Optimize: cache key for command CMD ["/bin/bash", "-c", "tail -f /var/log/messages"] c04c1cb059904feb0122bbc016ac901d80c62255082919b6938b979f4d9de403
INFO[0002] Skipping unpacking as no commands require it.
INFO[0002] CMD ["/bin/bash", "-c", "tail -f /var/log/messages"]
INFO[0002] No files changed in this command, skipping snapshotting.
DEBU[0002] Build: composite key for command CMD ["/bin/bash", "-c", "tail -f /var/log/messages"] &{[sha256:02410fbfad7f2842cce3cf7655828424f4f7f6b5105b0016e24f1676f3bd15f5 CMD [/bin/bash, -c, tail -f /var/log/messages]]}
DEBU[0002] Build: cache key for command CMD ["/bin/bash", "-c", "tail -f /var/log/messages"] c04c1cb059904feb0122bbc016ac901d80c62255082919b6938b979f4d9de403
DEBU[0002] Mapping stage idx 0 to digest sha256:7edeeb07b45d6e4e2a29ed54f79320e1903bf5c8a48081cf9e12db9f5dfb0cf9
DEBU[0002] Mapping digest sha256:7edeeb07b45d6e4e2a29ed54f79320e1903bf5c8a48081cf9e12db9f5dfb0cf9 to cachekey c04c1cb059904feb0122bbc016ac901d80c62255082919b6938b979f4d9de403
INFO[0002] Pushing image to localhost:5000/ubuntu-from-kaniko:v3
INFO[0002] Pushed localhost:5000/ubuntu-from-kaniko@sha256:c6afac4c7bbc0752a4a1e2fb0d8b9cf3276197be81387db899f001608accd2ae
```