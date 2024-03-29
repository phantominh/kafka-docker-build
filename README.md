# I. Guide to Kafka/Zookeeper Installation with SSL/SASL

## 1. SSL/SASL Configuration

### a. SSL
#### Go to ./secrets folder, if no certificate found, run the shellscript below:
```shellscript
sh create-certs.sh
``` 
If the client is using Python, we need to convert .jks certificates to .pem:
```shellscript
# Convert kafka certificates
# Extract the client certificates
keytool -exportcert -alias CARoot -keystore kafka.broker.keystore.jks \
        -rfc -file certificate.pem

# Extract the clients key
keytool -v -importkeystore -srckeystore kafka.broker.keystore.jks \
        -srcalias CARoot -destkeystore cert_and_key.p12 -deststoretype PKCS12
openssl pkcs12 -in cert_and_key.p12 -nocerts -nodes -out key.pem

# Extract CARoot certificate
keytool -exportcert -alias CARoot -keystore kafka.broker.keystore.jks -rfc \
        -file CARoot.pem

# Do the same thing to zookeeper certificates
keytool -exportcert -alias CARoot -keystore kafka.zookeeper.keystore.jks \
        -rfc -file certificate.pem
keytool -v -importkeystore -srckeystore kafka.zookeeper.keystore.jks \
        -srcalias CARoot -destkeystore cert_and_key.p12 -deststoretype PKCS12
openssl pkcs12 -in cert_and_key.p12 -nocerts -nodes -out key.pem
keytool -exportcert -alias CARoot -keystore kafka.zookeeper.keystore.jks -rfc \
        -file CARoot.pem
``` 
Reference: http://maximilianchrist.com/python/databases/2016/08/13/connect-to-apache-kafka-from-python-using-ssl.html

### b. SASL
#### Go to ./sasl-scram/secrets
Edit the configuration file to fit your own purpose

## 2. Zookeeper Configuration
### Make changes to start-zookeeper.sh to satisfy your machine environment:
- "ZOO\_IP_ADDRESS": Zookeeper IP Address
- "zookeeper.yml": Zookeeper Configuration File

### Init Zookeeper:
```shellscript
sh start-zookeeper.sh
```  

## 3. Install Kafka Brokers:
### Configurate start-broker.sh:
- "ZOO\_IP_ADDRESS": Zookeeper IP Address
- "BROKER\_IP_ADDRESS": Broker's IP Address
- "broker.yml": Kafka Broker Configuration File

### Init Broker:
```shellscript
sh start-broker.sh
``` 

