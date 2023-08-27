FROM ubuntu:22.04 AS base_layer

RUN apt-get update -y && \
    apt-get upgrade -y

FROM base_layer AS add_pkgs
RUN apt-get install -y \
    gnupg \
    vim \
    curl \
    wget \
    net-tools

FROM add_pkgs AS config
WORKDIR /data
COPY data/generate-key-config.txt /data
COPY data/*.sh /data/
COPY data/*.env /data/
# NOTE: copying existing private & public key
COPY data/.*.key /opt/
RUN chmod +x *.sh

FROM config AS generate_key

ARG KEY_GENERATOR_CONFIG=${KEY_GENERATOR_CONFIG}
ARG FILE_TO_ENCRYPT=${FILE_TO_ENCRYPT}
ARG OUTPUT_OF_ENCRYPTED_FILE=${OUTPUT_OF_ENCRYPTED_FILE}
ARG USE_EXISTING_KEY=${USE_EXISTING_KEY}

RUN chmod +x generate_gpg_keys.sh && \
    ./generate_gpg_keys.sh ${KEY_GENERATOR_CONFIG} ${USE_EXISTING_KEY}

RUN chmod +x import_gpg_keys.sh && \
    ./import_gpg_keys.sh

CMD [ "/bin/bash", "-c", "./encrypt_gpg_files.sh $KEY_GENERATOR_CONFIG $OUTPUT_OF_ENCRYPTED_FILE $FILE_TO_ENCRYPT $USE_EXISTING_KEY"]
