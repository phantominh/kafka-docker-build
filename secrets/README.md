# Cài đặt SSL cho Kafka/Zookeeper

#### 1. Cài đặt SSL
```shell script
sh create-certs.sh
``` 
Nếu Client chạy bằng Python, cần chuyển Certificates từ định dạng .jks thành .pem như sau:
```shell script
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

# Làm tương tự với Zookeeper
keytool -exportcert -alias CARoot -keystore kafka.zookeeper.keystore.jks \
        -rfc -file certificate.pem
keytool -v -importkeystore -srckeystore kafka.zookeeper.keystore.jks \
        -srcalias CARoot -destkeystore cert_and_key.p12 -deststoretype PKCS12
openssl pkcs12 -in cert_and_key.p12 -nocerts -nodes -out key.pem
keytool -exportcert -alias CARoot -keystore kafka.zookeeper.keystore.jks -rfc \
        -file CARoot.pem
``` 
#### 2. Link tham khảo
http://maximilianchrist.com/python/databases/2016/08/13/connect-to-apache-kafka-from-python-using-ssl.html
