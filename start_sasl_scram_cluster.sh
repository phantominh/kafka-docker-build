#!/usr/bin/env bash

export IP_ADDRESS=192.168.1.27
export KAFKA_SSL_SECRETS_DIR=$PWD/secrets
export KAFKA_SASL_SCRAM_SECRETS_DIR=$PWD/sasl-scram/secrets
cd $PWD/sasl-scram/
sudo -E docker-compose -f docker-compose-scram.yml up -d
