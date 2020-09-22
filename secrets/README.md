# Cài đặt Kafka trên server

#### 1. Cài đặt SSL
```shell script
# Create CA
 export CA_AUTHORITY_CN="MyCAauthority"
 sh ca_authority.sh

# Generate Server Certificates
 export SERVER_CN="kafka"
 export SERVER_KEY_PASS="serverpassword"
 sh generate_server_certificate.sh

# Generate Client Certificates
 export CLIENT_CN="client"
 export CLIENT_KEY_PASS="clientpassword"
 sh generate_client_certificate.sh
``` 
Nếu Client chạy bằng Python, cần chuyển Certificates từ định dạng .jks thành .pem như sau:
```shell script
cd client_certs_folder

# Extract the client certificates
keytool -exportcert -alias CARoot -keystore kafka.client.keystore.jks \
        -rfc -file certificate.pem

# Extract the clients key
keytool -v -importkeystore -srckeystore kafka.client.keystore.jks \
        -srcalias CARoot -destkeystore cert_and_key.p12 -deststoretype PKCS12
openssl pkcs12 -in cert_and_key.p12 -nocerts -nodes

# Extract CARoot certificate
keytool -exportcert -alias CARoot -keystore kafka.client.keystore.jks -rfc \
        -file CARoot.pem
``` 
#### 2. Cài đặt SASL
Chỉnh sửa file "kafka_server_jaas.conf"

#### 3. Cấu hình Kafka và Zookeeper
Chỉnh sửa file docker-compose.yml.
Vào file start.sh, nhập giá trị cho biến IP_ADDRESS là Public IP của Zookeeper và Kafka Broker.
##### Chạy:
```shell script
sh start.sh
``` 

#### 4. Link tham khảo
https://github.com/jinternals/kafka_ssl_setup/tree/master/Part%202
http://maximilianchrist.com/python/databases/2016/08/13/connect-to-apache-kafka-from-python-using-ssl.html