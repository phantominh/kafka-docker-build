#!/usr/bin/env bash

export BROKER_IP_ADDRESS=192.168.1.112
export ZOO_IP_ADDRESS=192.168.1.135
export KAFKA_SSL_SECRETS_DIR=$PWD/secrets
export KAFKA_SASL_SCRAM_SECRETS_DIR=$PWD/sasl-scram/secrets
cd $PWD/sasl-scram/
sudo -E docker-compose -f zookeeper.yml up -d