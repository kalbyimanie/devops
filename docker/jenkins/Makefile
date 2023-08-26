# Variables
LOCAL_REGISTRY_COMPOSE_FILE := local-registry-docker-compose.yaml

JENKINS_IMAGE_TAG := jenkins-master-local
JENKINS_DOCKER_FILE := jenkins.Dockerfile
LOCAL_REGISTRY_BASE_URI := localhost:5000
JENKINS_DATA := jenkins-data
DATE := $(shell date "+%H.%M.%S_%d-%m-%Y")

# Targets
.PHONY: push-jenkins-image-to-local-registry build-jenkins-image local-registry

# NOTE: LOCAL REGISTRY SECTION
local-registry:
	$(info SETUP LOCAL REGISTRY...)
	docker-compose -f $(LOCAL_REGISTRY_COMPOSE_FILE) up -d --remove-orphans --force-recreate

# NOTE: JENKINS SECTION
build-jenkins-image:
	$(info BUILD JENKINS IMAGE...)
	docker build -t $(JENKINS_IMAGE_TAG) \
	--build-arg=JENKINS_VERSION=2.415 \
	-f $(JENKINS_DOCKER_FILE) .

push-jenkins-image-to-local-registry: local-registry build-jenkins-image
	$(info TAG JENKINS IMAGE...)
	docker tag $(JENKINS_IMAGE_TAG) $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_IMAGE_TAG):$(DATE)

	$(info PUSH JENKINS IMAGE TO LOCAL REGISTRY...)
	docker push $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_IMAGE_TAG):$(DATE)

	docker tag $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_IMAGE_TAG):$(DATE) $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_IMAGE_TAG):latest

	docker push $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_IMAGE_TAG):latest

cleanup-jenkins-images-in-local-registry:
	$(info CLEAN UP JENKINS IMAGE IN LOCAL REGISTRY...)
	docker rmi -f $(docker images|grep -i "localhost:5000/jenkins-master-local"|awk '{print $3}')

cleanup-jenkins-data:
	$(info CLEAN UP JENKINS DATA...)
	rm -rfv $(JENKINS_DATA)
	mkdir $(JENKINS_DATA)

cleanup-dockerized-jenkins:
	docker-compose down --volumes --rmi all


setup-dockerized-jenkins:
	docker-compose up --build --force-recreate --remove-orphans

# NOTE: ENC/DEC SECTION
setup-encryptor:
	$(info SETUP ENCRYPTOR SERVICE...)
	cd ../gnupg && \
	docker-compose -f encryptor-docker-compose.yaml up --build --force-recreate --remove-orphans

setup-decryptor:
	$(info SETUP DECRYPTOR SERVICE...)
	cd ../gnupg && \
	docker build -t gnu-decryptor:base \
	--build-arg=KEY_GENERATOR_CONFIG=generate-key-config.txt \
	--build-arg=FILE_TO_ENCRYPT=jenkins.env \
	--build-arg=OUTPUT_OF_ENCRYPTED_FILE=jenkins.env.enc \
	-f encryptor.Dockerfile . && \
	docker-compose -f decryptor-docker-compose.yaml up --build --force-recreate --remove-orphans

