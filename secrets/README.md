# Cài đặt Kafka trên server

#### 1. Cài đặt SSL
```shell script
sh create-certs.sh
``` 
Nếu Client chạy bằng Python, cần chuyển Certificates từ định dạng .jks thành .pem như sau:
```shell script
# Extract the client certificates
keytool -exportcert -alias CARoot -keystore kafka.broker-1.keystore.jks \
        -rfc -file certificate.pem

# Extract the clients key
keytool -v -importkeystore -srckeystore kafka.broker-1.keystore.jks \
        -srcalias CARoot -destkeystore cert_and_key.p12 -deststoretype PKCS12
openssl pkcs12 -in cert_and_key.p12 -nocerts -nodes -out key.pem

# Extract CARoot certificate
keytool -exportcert -alias CARoot -keystore kafka.broker-1.keystore.jks -rfc \
        -file CARoot.pem
``` 
#### 2. Cài đặt SASL
#### 3. Link tham khảo
https://github.com/jinternals/kafka_ssl_setup/tree/master/Part%202
http://maximilianchrist.com/python/databases/2016/08/13/connect-to-apache-kafka-from-python-using-ssl.html
