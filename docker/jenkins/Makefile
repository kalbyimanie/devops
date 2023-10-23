# Variables
LOCAL_REGISTRY_COMPOSE_FILE := local-registry-docker-compose.yaml
JENKINS_VERSION := 2.428
JENKINS_IMAGE_TAG := jenkins-master-local-version-$(JENKINS_VERSION)
JENKINS_SLAVE_IMAGE_TAG := jenkins-slave-local
JENKINS_DOCKER_FILE := jenkins.Dockerfile
JENKINS_SLAVE_DOCKER_FILE := jenkins-slave.Dockerfile
LOCAL_REGISTRY_BASE_URI := localhost:5000
DOCKER_HUB_REGISTRY_BASE_URI := kalbyimanie/jenkins
DOCKER_HUB_JENKINS_MASTER_REGISTRY_BASE_URI := kalbyimanie/jenkins-master
JENKINS_DATA := jenkins-data
DATE := $(shell date "+%H.%M.%S_%d-%m-%Y")

USE_EXISTING_KEY := $(shell cat ../gnupg/encryptor-docker-compose.yaml| grep -i 'USE_EXISTING_KEY'|grep -vi '\#'|awk -F'\=' '{print $$2}'|uniq|sed '/^$$/d')

# Targets
.PHONY: push-jenkins-image-to-local-registry build-jenkins-image local-registry

# NOTE: LOCAL REGISTRY SECTION
local-registry:
	$(info SETUP LOCAL REGISTRY...)
	docker-compose -f $(LOCAL_REGISTRY_COMPOSE_FILE) up --force-recreate -d

# NOTE: JENKINS SECTION
build-new-jenkins-slave-image:

	$(info BUILD JENKINS SLAVE IMAGE...)
	docker build -t $(JENKINS_SLAVE_IMAGE_TAG):$(DATE) -t latest \
	-f $(JENKINS_SLAVE_DOCKER_FILE) .

	$(info TAG JENKINS SLAVE IMAGE...)
	docker tag $(JENKINS_SLAVE_IMAGE_TAG):$(DATE) $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_SLAVE_IMAGE_TAG):$(DATE)

	docker tag $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_SLAVE_IMAGE_TAG):$(DATE) $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_SLAVE_IMAGE_TAG):latest

	$(info PUSH JENKINS SLAVE IMAGE TO LOCAL REGISTRY...)
	docker push $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_SLAVE_IMAGE_TAG):latest

push-new-jenkins-slave-image-to-docker-hub: build-new-jenkins-slave-image

	$(info TAG JENKINS SLAVE IMAGE...)
	docker tag $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_SLAVE_IMAGE_TAG):$(DATE) $(DOCKER_HUB_REGISTRY_BASE_URI):$(JENKINS_SLAVE_IMAGE_TAG)_$(DATE)

	docker tag $(DOCKER_HUB_REGISTRY_BASE_URI):$(JENKINS_SLAVE_IMAGE_TAG)_$(DATE) $(DOCKER_HUB_REGISTRY_BASE_URI):jenkins-slave-latest

	$(info PUSH JENKINS SLAVE IMAGE TO DOCKERHUB...)
	docker push $(DOCKER_HUB_REGISTRY_BASE_URI):$(JENKINS_SLAVE_IMAGE_TAG)_$(DATE)

	docker push $(DOCKER_HUB_REGISTRY_BASE_URI):jenkins-slave-latest

build-jenkins-slave-image:
	$(info PULL AND TAG JENKINS SLAVE IMAGE...)
	docker pull kalbyimanie/jenkins:slave-v3
	docker tag kalbyimanie/jenkins:slave-v3 $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_SLAVE_IMAGE_TAG):$(DATE)

	docker tag $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_SLAVE_IMAGE_TAG):$(DATE) $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_SLAVE_IMAGE_TAG):latest

	$(info PUSH JENKINS SLAVE IMAGE TO LOCAL REGISTRY...)
	docker push $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_SLAVE_IMAGE_TAG):$(DATE)

	docker push $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_SLAVE_IMAGE_TAG):latest

build-jenkins-image:
	$(info BUILD JENKINS IMAGE...)
	docker build -t $(JENKINS_IMAGE_TAG) -t latest \
	--build-arg=JENKINS_VERSION=$(JENKINS_VERSION) \
	-f $(JENKINS_DOCKER_FILE) .

push-jenkins-master-image-to-local-registry: local-registry build-jenkins-image build-jenkins-slave-image
	$(info TAG JENKINS MASTER IMAGE...)
	docker tag $(JENKINS_IMAGE_TAG) $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_IMAGE_TAG):$(DATE)

	docker tag $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_IMAGE_TAG):$(DATE) $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_IMAGE_TAG):latest

	$(info PUSH JENKINS MASTER IMAGE TO LOCAL REGISTRY...)
	docker push $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_IMAGE_TAG):$(DATE)
	docker push $(LOCAL_REGISTRY_BASE_URI)/$(JENKINS_IMAGE_TAG):latest

push-jenkins-master-image-to-docker-hub: build-jenkins-image
	$(info TAG JENKINS MASTER IMAGE...)
	docker tag $(JENKINS_IMAGE_TAG) $(DOCKER_HUB_JENKINS_MASTER_REGISTRY_BASE_URI):$(JENKINS_IMAGE_TAG)-$(DATE)

	docker tag $(DOCKER_HUB_JENKINS_MASTER_REGISTRY_BASE_URI):$(JENKINS_IMAGE_TAG)-$(DATE) $(DOCKER_HUB_JENKINS_MASTER_REGISTRY_BASE_URI):latest

	$(info PUSH JENKINS MASTER IMAGE TO DOCKER HUB...)
	docker push $(DOCKER_HUB_JENKINS_MASTER_REGISTRY_BASE_URI):$(JENKINS_IMAGE_TAG)-$(DATE)
	docker push $(DOCKER_HUB_JENKINS_MASTER_REGISTRY_BASE_URI):latest

cleanup-jenkins-images-in-local-registry:
	$(info CLEAN UP JENKINS IMAGE IN LOCAL REGISTRY...)
	docker rmi -f $(docker images|grep -i "localhost:5000/jenkins-master-local"|awk '{print $3}')

cleanup-jenkins-data:
	$(info CLEAN UP JENKINS DATA...)
	rm -rfv $(JENKINS_DATA)
	mkdir $(JENKINS_DATA)

cleanup-dockerized-jenkins:
	$(info CLEAN UP DOCKERIZED JENKINS...)
	docker-compose down --volumes --rmi all


setup-dockerized-jenkins-no-build: local-registry
	docker-compose -f docker-compose-no-build.yaml up

setup-dockerized-jenkins: local-registry build-jenkins-slave-image
	$(info SETUP DOCKERIZED JENKINS...)
	cd scripts && \
	bash copy_jenkins_env.sh && \
	cd ../ && \
	docker-compose up --build

# NOTE: ENC/DEC SECTION
setup-encryptor:
	$(info SETUP ENCRYPTOR SERVICE...)
	cd ../gnupg && \
	docker-compose -f encryptor-docker-compose.yaml up --build

setup-decryptor:
	$(info SETUP DECRYPTOR SERVICE...)
	$(info USE_EXISTING_KEY=$(USE_EXISTING_KEY))
	cd ../gnupg && \
	docker build -t gnu-decryptor:base \
	--build-arg=KEY_GENERATOR_CONFIG=generate-key-config.txt \
	--build-arg=FILE_TO_ENCRYPT=jenkins.env \
	--build-arg=OUTPUT_OF_ENCRYPTED_FILE=jenkins.env.enc \
	--build-arg=USE_EXISTING_KEY=$(USE_EXISTING_KEY) \
	-f encryptor.Dockerfile . && \
	docker-compose -f decryptor-docker-compose.yaml up --build

