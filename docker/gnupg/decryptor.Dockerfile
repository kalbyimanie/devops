FROM gnu-decryptor:base

WORKDIR /data
COPY data/*.sh /data/
RUN chmod +x *.sh

CMD [ "/bin/bash", "-c", "./decrypt_gpg_files.sh $KEY_GENERATOR_CONFIG $OUTPUT_DECRYPTED_FILE $INPUT_ENCRYPTED_FILE"]
