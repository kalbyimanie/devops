# Variables
LOCAL_REGISTRY_COMPOSE_FILE := local-registry-docker-compose.yaml

JENKINS_IMAGE_TAG := jenkins-master-local
JENKINS_DOCKER_FILE := jenkins.Dockerfile
LOCAL_REGISTRY_BASE_URI := localhost:5000
JENKINS_DATA := jenkins-data
DATE := $(shell date "+%H.%M.%S_%d-%m-%Y")

# Targets
.PHONY: push-jenkins-image-to-local-registry build-jenkins-image local-registry

local-registry:
	echo "setting up local-registry..."
	docker-compose -f $(LOCAL_REGISTRY_COMPOSE_FILE) up -d --remove-orphans --force-recreate

build-jenkins-image:
	echo "build jenkins image..."
	docker build -t $(JENKINS_IMAGE_TAG) \
	--build-arg=JENKINS_VERSION=2.415 \
	-f $(JENKINS_DOCKER_FILE) .

push-jenkins-image-to-local-registry: local-registry build-jenkins-image
	echo "build jenkins image..."
	docker tag $(JENKINS_IMAGE_TAG) $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_IMAGE_TAG):$(DATE)

	docker push $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_IMAGE_TAG):$(DATE)

	docker tag $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_IMAGE_TAG):$(DATE) $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_IMAGE_TAG):latest

	docker push $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_IMAGE_TAG):latest

cleanup-jenkins-images-in-local-registry:
	docker rmi -f $(docker images|grep -i "localhost:5000/jenkins-master-local"|awk '{print $3}')

cleanup-jenkins-data:
	rm -rfv $(JENKINS_DATA)
	mkdir $(JENKINS_DATA)

cleanup-dockerized-jenkins:
	docker-compose down --volumes --rmi all


setup-dockerized-jenkins:
	docker-compose up --build --force-recreate --remove-orphans


setup-encryptor:
	echo "setup encryptor service..."
	cd ../gnupg && \
	docker-compose -f encryptor-docker-compose.yaml up --build --force-recreate --remove-orphans

setup-decryptor:
	echo "build decryptor service..."
	cd ../gnupg && \
	docker build -t gnu-decryptor:base \
	--build-arg=KEY_GENERATOR_CONFIG=generate-key-config.txt \
	--build-arg=FILE_TO_ENCRYPT=jenkins.env \
	--build-arg=OUTPUT_OF_ENCRYPTED_FILE=jenkins.env.enc \
	-f encryptor.Dockerfile . && \
	docker-compose -f decryptor-docker-compose.yaml up --build --force-recreate --remove-orphans

