# I. Cài đặt Kafka/Zookeeper trên Server

## 1. Cấu hình SSL/SASL

### a. SSL
#### Vào thư mục ./secrets, nếu chưa có certificate thì chạy:
```shellscript
sh create-certs.sh
``` 
Nếu Client chạy bằng Python, cần chuyển Certificates từ định dạng .jks thành .pem như sau:
```shellscript
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
Link tham khảo: http://maximilianchrist.com/python/databases/2016/08/13/connect-to-apache-kafka-from-python-using-ssl.html

### b. SASL
####Vào thư mục ./sasl-scram/secrets
Sửa các file config trong thư mục đó (nếu cần)

## 2. Cài đặt Zookeeper
### Sửa một số giá trị trong file start-zookeeper.sh:
- "ZOO\_IP_ADDRESS": Địa chỉ IP của Zookeeper
- "zookeeper.yml": File cấu hình Zookeeper

### Khởi tạo Zookeeper:
```shellscript
sh start-zookeeper.sh
```  

## 3. Cài đặt Kafka Broker:
### Sửa một số giá trị trong file start-broker.sh:
- "ZOO\_IP_ADDRESS": Địa chỉ IP của Zookeeper
- "BROKER\_IP_ADDRESS": Địa chỉ IP của Broker sắp được khởi tạo
- "broker.yml": File cấu hình Kafka Broker

### Khởi tạo Broker:
```shellscript
sh start-broker.sh
``` 

