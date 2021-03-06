# Part2
## Target: debug local app via CF's service
*Use Branch: solution-21-Receive-MQ-Messages*

*2 dependencies: PostgreSQL, RabbitMQ*

Check the service we used
```shell
# if need
# cf service-keys postgreSQLv9.4-dev
# cf create-service-key postgreSQLv9.4-dev access-key

cf service-key postgreSQLv9.4-dev access-key
```
```json
{
 "dbname": "HeaHvsu6V9KBD4PY",
 "end_points": [
  {
   "host": "10.11.241.0",
   "network_id": "SF",
   "port": "52791"
  }
 ],
 "hostname": "10.11.241.0",
 "password": "qC5gZ7DHO5FY59sG",
 "port": "52791",
 "ports": {
  "5432/tcp": "52791"
 },
 "uri": "postgres://lNTt6T-3FV7veQuq:qC5gZ7DHO5FY59sG@10.11.241.0:52791/HeaHvsu6V9KBD4PY",
 "username": "lNTt6T-3FV7veQuq"
}
```
```shell
cf service-key rabbitMQv3.6-dev access-key
```
```json
{
 "end_points": [
  {
   "host": "10.11.241.0",
   "network_id": "SF",
   "port": "42979"
  }
 ],
 "hostname": "10.11.241.0",
 "password": "g041Z6BpHKgAkB9k",
 "port": "42979",
 "ports": {
  "15672/tcp": "58492",
  "15674/tcp": "55055",
  "15675/tcp": "60352",
  "1883/tcp": "44903",
  "5672/tcp": "42979",
  "61613/tcp": "60433"
 },
 "uri": "amqp://wGk7ZIrnn6apZNFH:g041Z6BpHKgAkB9k@10.11.241.0:42979",
 "username": "wGk7ZIrnn6apZNFH"
}
```
Configure SSH Tunnel
```shell
cf ssh -L <<your port>>:<<service host or ip>>:<<service port>> <<app name>>
```
```shell
cf ssh -L 5432:10.11.241.0:52791 approuter
cf ssh -L 5672:10.11.241.0:42979 bill-bulletinboard-ads
```
Change local environment
```json
{
   "postgresql-9.3": [
      {
         "name": "postgresql-lite",
         "label": "postgresql-9.3",
         "credentials": {
            "dbname": "HeaHvsu6V9KBD4PY",
            "hostname": "127.0.0.1",
            "password": "qC5gZ7DHO5FY59sG",
            "port": "5432",
            "uri": "postgres://lNTt6T-3FV7veQuq:qC5gZ7DHO5FY59sG@127.0.0.1:5432/HeaHvsu6V9KBD4PY",
            "username": "lNTt6T-3FV7veQuq"
         },
         "tags": [
            "relational",
            "postgresql"
         ],
         "plan": "free"
      }
   ],
   "rabbitmq-lite": [
      {
         "credentials": {
            "hostname": "127.0.0.1",
            "password": "g041Z6BpHKgAkB9k",
            "uri": "amqp:://wGk7ZIrnn6apZNFH:g041Z6BpHKgAkB9k@127.0.0.1:5672",
            "username": "wGk7ZIrnn6apZNFH"
         },
         "label": "rabbitmq-lite",
         "tags": [
            "rabbitmq33",
            "rabbitmq",
            "amqp"
         ]
      }
   ]
}
```
Export it to env
```shell
export VCAP_SERVICES='{ "postgresql-9.3":[ { "name":"postgresql-lite", "label":"postgresql-9.3", "credentials":{ "dbname":"HeaHvsu6V9KBD4PY", "hostname":"127.0.0.1", "password":"qC5gZ7DHO5FY59sG", "port":"5432", "uri":"postgres://lNTt6T-3FV7veQuq:qC5gZ7DHO5FY59sG@127.0.0.1:5432/HeaHvsu6V9KBD4PY", "username":"lNTt6T-3FV7veQuq" }, "tags":[ "relational", "postgresql" ], "plan":"free" } ], "rabbitmq-lite":[ { "credentials":{ "hostname":"127.0.0.1", "password":"g041Z6BpHKgAkB9k", "uri":"amqp://wGk7ZIrnn6apZNFH:g041Z6BpHKgAkB9k@127.0.0.1:5672", "username":"wGk7ZIrnn6apZNFH" }, "label":"rabbitmq-lite", "tags":[ "rabbitmq33", "rabbitmq", "amqp" ] } ] }'
```
Run it in local Tomcat
```shell
./bin/catalina.sh run
```
Start Tomcat with debug mode
```shell
export CATALINA_OPTS='-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=127.0.0.1:8000'
```
Debug local app
### Reference
* <https://docs.cloudfoundry.org/devguide/deploy-apps/ssh-services.html>
* <http://cli.cloudfoundry.org/en-US/cf/>

---
## Target: debug local app including authentication and authorization
*Branch: solution-24-Make-App-Secure*

*3 dependencies: PostgreSQL, RabbitMQ, XSUAA(no Docker image)*
### via CF's XSUAA service instance
Check instance value
```shell
cf service-key uaa-bulletinboard access-key
```
```json
{
 "clientid": "sb-bulletinboard-i333244!t431",
 "clientsecret": "SCU3s7F0zGniNgc/bNt7fa71hhc=",
 "identityzone": "i333244trial",
 "identityzoneid": "093365a4-c6e9-4419-8f30-5e6eae8159b8",
 "sburl": "https://internal-xsuaa.authentication.us30.hana.ondemand.com",
 "tenantid": "093365a4-c6e9-4419-8f30-5e6eae8159b8",
 "tenantmode": "shared",
 "uaadomain": "authentication.us30.hana.ondemand.com",
 "url": "https://i333244trial.authentication.us30.hana.ondemand.com",
 "verificationkey": "-----BEGIN PUBLIC KEY-----MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA5+N6Qb8hPfDCxKiFUCW5P3WSOk2BGMc+hBO0qyqaPhHDT7N8LlaGX7u5KvNh0f3eloMBtxMo/ZgF5yxCrvin4G/9fFG6C61EJ4QV2qbNmi8l8X2LyTBGSgLggYKZItq9pfDJdId3AaXjGeQBBcAgvfUimGoynvwuK/hnCx8JQhLGa+7C20srJfKv1/n3jZ/sfVSvJ0nm8joeRzaJrh5i9Wu+ewcB05cZ8xR2sLlKehO+TSCrStVh1hYUAu0uycDThTSHSaXi+1zc0N+SPJXM/1PVMJzENAaB0gWq1TNElOgdc5L1Fmo5vjNUc/on9Qg9v70A+meQsJgC5xx5rihNCstVJUS2sikTRL91Qmjv/XpweUV9vZpZTJ61ELBsxMPJAsLW9kVcon49YnIG/0EzJLyPxKo4bcd7ZqJxLQkIWqzH9XAPhu4GQtnMY5NWcrkU0dKabpbIbQ8ThyOe9rpluCQvjdSYXNzeIwxFy/mETtyn3ro7wSFqc3w143UuQgw7N8/1pyVGu1dojStsw1fiz754vAH2P2xrNzmfVTvcHyImbCUWStz0wsLMvCjtJZ86XF5XUQKmybYX+0GFgdYgu1dzBYI+NOUvDDPGDkTa47eOGwljKS2cvRtPdAXXc+3l3AsBQyld1KlH+v//rgtgg2n2Czbxw4N+34y/FTrYso8CAwEAAQ==-----END PUBLIC KEY-----",
 "xsappname": "bulletinboard-i333244!t431"
}
```
***1st way: Get token from service instance***
```
POST /oauth/token HTTP/1.1
Content-Type: application/x-www-form-urlencoded
Accept: application/json
Host: localhost

client_id=app&client_secret=appclientsecret&grant_type=password&username=W2ZfTS%40test.org&password=secr3T&token_format=opaque&login_hint=%7B%22origin%22%3A%22uaa%22%7D
```
![Get token](https://raw.githubusercontent.com/trulliandloeb/docker-cf-local-hands-on/master/resource/oauth-token.png)

Start local postgre and rabbitMQ
```shell
docker run --rm \
    --name some-postgres \
    -e POSTGRES_PASSWORD=test123! \
    -e POSTGRES_USER=testuser \
    -e POSTGRES_DB=test \
    -it \
    -p 5432:5432 \
    --network bill-network \
    postgres:9.4-alpine
    
docker run --rm \
    --name my-rmq \
    -it \
    --hostname my-rmq \
    -p 5672:5672 \
    --network bill-network \
    rabbitmq:3.7.14-alpine
```
Change local environment variables
```json
{
   "postgresql-9.3":[
      {
         "name":"postgresql-lite",
         "label":"postgresql-9.3",
         "credentials":{
            "dbname":"test",
            "hostname":"127.0.0.1",
            "password":"test123!",
            "port":"5432",
            "uri":"postgres://testuser:test123!@localhost:5432/test",
            "username":"testuser"
         },
         "tags":[
            "relational",
            "postgresql"
         ],
         "plan":"free"
      }
   ],
   "rabbitmq-lite":[
      {
         "credentials":{
            "hostname":"127.0.0.1",
            "password":"guest",
            "uri":"amqp://guest:guest@127.0.0.1:5672",
            "username":"guest"
         },
         "label":"rabbitmq-lite",
         "tags":[
            "rabbitmq33",
            "rabbitmq",
            "amqp"
         ]
      }
   ],
   "xsuaa":[
      {
         "binding_name":null,
         "credentials":{
            "clientid":"sb-bulletinboard-i333244!t431",
            "clientsecret":"SCU3s7F0zGniNgc/bNt7fa71hhc=",
            "identityzone":"i333244trial",
            "identityzoneid":"093365a4-c6e9-4419-8f30-5e6eae8159b8",
            "sburl":"https://internal-xsuaa.authentication.us30.hana.ondemand.com",
            "tenantid":"093365a4-c6e9-4419-8f30-5e6eae8159b8",
            "tenantmode":"shared",
            "uaadomain":"authentication.us30.hana.ondemand.com",
            "url":"https://i333244trial.authentication.us30.hana.ondemand.com",
            "verificationkey":"-----BEGIN PUBLIC KEY-----MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA5+N6Qb8hPfDCxKiFUCW5P3WSOk2BGMc+hBO0qyqaPhHDT7N8LlaGX7u5KvNh0f3eloMBtxMo/ZgF5yxCrvin4G/9fFG6C61EJ4QV2qbNmi8l8X2LyTBGSgLggYKZItq9pfDJdId3AaXjGeQBBcAgvfUimGoynvwuK/hnCx8JQhLGa+7C20srJfKv1/n3jZ/sfVSvJ0nm8joeRzaJrh5i9Wu+ewcB05cZ8xR2sLlKehO+TSCrStVh1hYUAu0uycDThTSHSaXi+1zc0N+SPJXM/1PVMJzENAaB0gWq1TNElOgdc5L1Fmo5vjNUc/on9Qg9v70A+meQsJgC5xx5rihNCstVJUS2sikTRL91Qmjv/XpweUV9vZpZTJ61ELBsxMPJAsLW9kVcon49YnIG/0EzJLyPxKo4bcd7ZqJxLQkIWqzH9XAPhu4GQtnMY5NWcrkU0dKabpbIbQ8ThyOe9rpluCQvjdSYXNzeIwxFy/mETtyn3ro7wSFqc3w143UuQgw7N8/1pyVGu1dojStsw1fiz754vAH2P2xrNzmfVTvcHyImbCUWStz0wsLMvCjtJZ86XF5XUQKmybYX+0GFgdYgu1dzBYI+NOUvDDPGDkTa47eOGwljKS2cvRtPdAXXc+3l3AsBQyld1KlH+v//rgtgg2n2Czbxw4N+34y/FTrYso8CAwEAAQ==-----END PUBLIC KEY-----",
            "xsappname":"bulletinboard-i333244!t431"
         },
         "instance_name":"uaa-bulletinboard",
         "label":"xsuaa",
         "name":"uaa-bulletinboard",
         "plan":"application",
         "provider":null,
         "syslog_drain_url":null,
         "tags":[
            "xsuaa"
         ],
         "volume_mounts":[

         ]
      }
   ]
}
```
```shell
export VCAP_SERVICES='{ "postgresql-9.3":[ { "name":"postgresql-lite", "label":"postgresql-9.3", "credentials":{ "dbname":"test", "hostname":"127.0.0.1", "password":"test123!", "port":"5432", "uri":"postgres://testuser:test123!@localhost:5432/test", "username":"testuser" }, "tags":[ "relational", "postgresql" ], "plan":"free" } ], "rabbitmq-lite":[ { "credentials":{ "hostname":"127.0.0.1", "password":"guest", "uri":"amqp://guest:guest@127.0.0.1:5672", "username":"guest" }, "label":"rabbitmq-lite", "tags":[ "rabbitmq33", "rabbitmq", "amqp" ] } ], "xsuaa":[ { "binding_name":null, "credentials":{ "clientid":"sb-bulletinboard-i333244!t431", "clientsecret":"SCU3s7F0zGniNgc/bNt7fa71hhc=", "identityzone":"i333244trial", "identityzoneid":"093365a4-c6e9-4419-8f30-5e6eae8159b8", "sburl":"https://internal-xsuaa.authentication.us30.hana.ondemand.com", "tenantid":"093365a4-c6e9-4419-8f30-5e6eae8159b8", "tenantmode":"shared", "uaadomain":"authentication.us30.hana.ondemand.com", "url":"https://i333244trial.authentication.us30.hana.ondemand.com", "verificationkey":"-----BEGIN PUBLIC KEY-----MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA5+N6Qb8hPfDCxKiFUCW5P3WSOk2BGMc+hBO0qyqaPhHDT7N8LlaGX7u5KvNh0f3eloMBtxMo/ZgF5yxCrvin4G/9fFG6C61EJ4QV2qbNmi8l8X2LyTBGSgLggYKZItq9pfDJdId3AaXjGeQBBcAgvfUimGoynvwuK/hnCx8JQhLGa+7C20srJfKv1/n3jZ/sfVSvJ0nm8joeRzaJrh5i9Wu+ewcB05cZ8xR2sLlKehO+TSCrStVh1hYUAu0uycDThTSHSaXi+1zc0N+SPJXM/1PVMJzENAaB0gWq1TNElOgdc5L1Fmo5vjNUc/on9Qg9v70A+meQsJgC5xx5rihNCstVJUS2sikTRL91Qmjv/XpweUV9vZpZTJ61ELBsxMPJAsLW9kVcon49YnIG/0EzJLyPxKo4bcd7ZqJxLQkIWqzH9XAPhu4GQtnMY5NWcrkU0dKabpbIbQ8ThyOe9rpluCQvjdSYXNzeIwxFy/mETtyn3ro7wSFqc3w143UuQgw7N8/1pyVGu1dojStsw1fiz754vAH2P2xrNzmfVTvcHyImbCUWStz0wsLMvCjtJZ86XF5XUQKmybYX+0GFgdYgu1dzBYI+NOUvDDPGDkTa47eOGwljKS2cvRtPdAXXc+3l3AsBQyld1KlH+v//rgtgg2n2Czbxw4N+34y/FTrYso8CAwEAAQ==-----END PUBLIC KEY-----", "xsappname":"bulletinboard-i333244!t431" }, "instance_name":"uaa-bulletinboard", "label":"xsuaa", "name":"uaa-bulletinboard", "plan":"application", "provider":null, "syslog_drain_url":null, "tags":[ "xsuaa" ], "volume_mounts":[ ] } ] }'
```
Start app locally, access it with token
![Send request with token](https://raw.githubusercontent.com/trulliandloeb/docker-cf-local-hands-on/master/resource/Snipaste_2019-05-19_11-17-40.png)
**2nd way: Config a local approuter***

default-env.json
```json
{
    "destinations": [
        {
            "name": "ads-destination",
            "url": "http://localhost:8080",
            "forwardAuthToken": true
        }
    ]
}
```
default-services.json
```json
{
    "uaa": {
        "url": "https://i333244trial.authentication.us30.hana.ondemand.com",
        "clientid": "sb-bulletinboard-i333244!t431",
        "clientsecret": "SCU3s7F0zGniNgc/bNt7fa71hhc=",
        "xsappname": "bulletinboard-i333244!t431"
    }
}
```
Run it
```shell
npm start
```
Access through approuter: http://localhost:5000/ads/api/v1/ads
### via local "XSUAA service"
Make own certificate

Generate private key
```shell
openssl genrsa -out bill_private.pem 2048
```
Export public key
```shell
openssl rsa -in bill_private.pem -outform PEM -pubout -out bill_public.pem
```
Sign the JWT
```shell
cd jsonwebtoken
node app.js
```
Config own public key to env
```shell
{ "postgresql-9.3":[ { "name":"postgresql-lite", "label":"postgresql-9.3", "credentials":{ "dbname":"test", "hostname":"127.0.0.1", "password":"test123!", "port":"5432", "uri":"postgres://testuser:test123!@localhost:5432/test", "username":"testuser" }, "tags":[ "relational", "postgresql" ], "plan":"free" } ], "rabbitmq-lite":[ { "credentials":{ "hostname":"127.0.0.1", "password":"guest", "uri":"amqp://guest:guest@127.0.0.1:5672", "username":"guest" }, "label":"rabbitmq-lite", "tags":[ "rabbitmq33", "rabbitmq", "amqp" ] } ], "xsuaa":[ { "credentials":{ "clientid":"bill-demo-client-id", "clientsecret":"bill-demo-clientsecret", "identityzone":"bill-demo-identityzone", "identityzoneid":"bill-demo-identityzoneid", "tenantid":"bill-demo-tenantid", "tenantmode":"shared", "url":"bill-demo-dummy-url", "verificationkey":"-----BEGIN PUBLIC KEY-----MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC1Ms8+eaZ/Af04VtxyxtXydz0PGnGKYWcbPGaCvVUb0Y5KtibykaNfC2zxqS9zwjimIm9PB+9YcDYEo/jhXzY6NIaowvryKR5YfiLPkODMkjFlNQh93o6CGhSrk6hkhJzvGAwQ0Md2uGJ5ZBigpPztvd5l9mptt8mq7e/WPoBylQIDAQAB-----END PUBLIC KEY-----", "xsappname":"bulletinboard-i333244" }, "label":"xsuaa", "name":"uaa-bulletinboard", "plan":"application", "tags":[ "xsuaa" ] } ] }
```
Access app with generated JWT

### Reference
* <https://github.com/auth0/node-jsonwebtoken>
* <https://blogs.sap.com/2018/08/31/how-to-get-an-access-token-from-the-xsuaa-service-for-external-api-accesses-using-the-password-grant-with-client-and-user-credentials-method/>
* <https://docs.cloudfoundry.org/api/uaa/version/4.31.0/index.html>
* <http://www.marcoder.com/2017/12/11/jwt-rsa/>
* <https://medium.com/@oyrxx/rsa%E7%A7%98%E9%92%A5%E4%BB%8B%E7%BB%8D%E5%8F%8Aopenssl%E7%94%9F%E6%88%90%E5%91%BD%E4%BB%A4-d3fcc689513f>
* <https://github.wdf.sap.corp/xs2/approuter.js>
