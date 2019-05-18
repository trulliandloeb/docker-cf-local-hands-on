# Part2
## Target: debug local app via CF's service
Use Branch: solution-21-Receive-MQ-Messages
```shell
#cf service-keys postgreSQLv9.4-dev
#cf create-service-key postgreSQLv9.4-dev access-key

cf service-key postgreSQLv9.4-dev access-key
```
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

https://docs.cloudfoundry.org/devguide/deploy-apps/ssh-services.html

https://github.com/auth0/node-jsonwebtoken

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

cf ssh -L 5432:10.11.241.0:52791 bill-bulletinboard-ads

cf service-key rabbitMQv3.6-dev access-key

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

cf ssh -L 5672:10.11.241.0:42979 bill-bulletinboard-ads

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

export VCAP_SERVICES='{ "postgresql-9.3":[ { "name":"postgresql-lite", "label":"postgresql-9.3", "credentials":{ "dbname":"HeaHvsu6V9KBD4PY", "hostname":"127.0.0.1", "password":"qC5gZ7DHO5FY59sG", "port":"5432", "uri":"postgres://lNTt6T-3FV7veQuq:qC5gZ7DHO5FY59sG@127.0.0.1:5432/HeaHvsu6V9KBD4PY", "username":"lNTt6T-3FV7veQuq" }, "tags":[ "relational", "postgresql" ], "plan":"free" } ], "rabbitmq-lite":[ { "credentials":{ "hostname":"127.0.0.1", "password":"g041Z6BpHKgAkB9k", "uri":"amqp://wGk7ZIrnn6apZNFH:g041Z6BpHKgAkB9k@127.0.0.1:5672", "username":"wGk7ZIrnn6apZNFH" }, "label":"rabbitmq-lite", "tags":[ "rabbitmq33", "rabbitmq", "amqp" ] } ] }'

http://cli.cloudfoundry.org/en-US/cf/

https://docs.cloudfoundry.org/devguide/deploy-apps/manifest-attributes.html#routes

https://docs.run.pivotal.io/devguide/deploy-apps/routes-domains.html

https://blogs.sap.com/2018/08/31/how-to-get-an-access-token-from-the-xsuaa-service-for-external-api-accesses-using-the-password-grant-with-client-and-user-credentials-method/

https://docs.cloudfoundry.org/api/uaa/version/4.31.0/index.html

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

{ "postgresql-9.3":[ { "name":"postgresql-lite", "label":"postgresql-9.3", "credentials":{ "dbname":"test", "hostname":"127.0.0.1", "password":"test123!", "port":"5432", "uri":"postgres://testuser:test123!@localhost:5432/test", "username":"testuser" }, "tags":[ "relational", "postgresql" ], "plan":"free" } ], "rabbitmq-lite":[ { "credentials":{ "hostname":"127.0.0.1", "password":"guest", "uri":"amqp://guest:guest@127.0.0.1:5672", "username":"guest" }, "label":"rabbitmq-lite", "tags":[ "rabbitmq33", "rabbitmq", "amqp" ] } ], "xsuaa":[ { "binding_name":null, "credentials":{ "clientid":"sb-bulletinboard-i333244!t431", "clientsecret":"SCU3s7F0zGniNgc/bNt7fa71hhc=", "identityzone":"i333244trial", "identityzoneid":"093365a4-c6e9-4419-8f30-5e6eae8159b8", "sburl":"https://internal-xsuaa.authentication.us30.hana.ondemand.com", "tenantid":"093365a4-c6e9-4419-8f30-5e6eae8159b8", "tenantmode":"shared", "uaadomain":"authentication.us30.hana.ondemand.com", "url":"https://i333244trial.authentication.us30.hana.ondemand.com", "verificationkey":"-----BEGIN PUBLIC KEY-----MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA5+N6Qb8hPfDCxKiFUCW5P3WSOk2BGMc+hBO0qyqaPhHDT7N8LlaGX7u5KvNh0f3eloMBtxMo/ZgF5yxCrvin4G/9fFG6C61EJ4QV2qbNmi8l8X2LyTBGSgLggYKZItq9pfDJdId3AaXjGeQBBcAgvfUimGoynvwuK/hnCx8JQhLGa+7C20srJfKv1/n3jZ/sfVSvJ0nm8joeRzaJrh5i9Wu+ewcB05cZ8xR2sLlKehO+TSCrStVh1hYUAu0uycDThTSHSaXi+1zc0N+SPJXM/1PVMJzENAaB0gWq1TNElOgdc5L1Fmo5vjNUc/on9Qg9v70A+meQsJgC5xx5rihNCstVJUS2sikTRL91Qmjv/XpweUV9vZpZTJ61ELBsxMPJAsLW9kVcon49YnIG/0EzJLyPxKo4bcd7ZqJxLQkIWqzH9XAPhu4GQtnMY5NWcrkU0dKabpbIbQ8ThyOe9rpluCQvjdSYXNzeIwxFy/mETtyn3ro7wSFqc3w143UuQgw7N8/1pyVGu1dojStsw1fiz754vAH2P2xrNzmfVTvcHyImbCUWStz0wsLMvCjtJZ86XF5XUQKmybYX+0GFgdYgu1dzBYI+NOUvDDPGDkTa47eOGwljKS2cvRtPdAXXc+3l3AsBQyld1KlH+v//rgtgg2n2Czbxw4N+34y/FTrYso8CAwEAAQ==-----END PUBLIC KEY-----", "xsappname":"bulletinboard-i333244!t431" }, "instance_name":"uaa-bulletinboard", "label":"xsuaa", "name":"uaa-bulletinboard", "plan":"application", "provider":null, "syslog_drain_url":null, "tags":[ "xsuaa" ], "volume_mounts":[ ] } ] }

http://www.marcoder.com/2017/12/11/jwt-rsa/

https://medium.com/@oyrxx/rsa%E7%A7%98%E9%92%A5%E4%BB%8B%E7%BB%8D%E5%8F%8Aopenssl%E7%94%9F%E6%88%90%E5%91%BD%E4%BB%A4-d3fcc689513f

eyJhbGciOiJSUzI1NiIsImprdSI6Imh0dHBzOi8vaTMzMzI0NHRyaWFsLmF1dGhlbnRpY2F0aW9uLnVzMzAuaGFuYS5vbmRlbWFuZC5jb20vdG9rZW5fa2V5cyIsImtpZCI6ImtleS1pZC0xIiwidHlwIjoiSldUIn0.eyJqdGkiOiIzNjk4MjRiNzExMTg0YjkwODM1YjhmYWQ3ZTM5ZDFkYiIsImV4dF9hdHRyIjp7ImVuaGFuY2VyIjoiWFNVQUEiLCJ6ZG4iOiJpMzMzMjQ0dHJpYWwifSwieHMuc3lzdGVtLmF0dHJpYnV0ZXMiOnsieHMucm9sZWNvbGxlY3Rpb25zIjpbImJpbGxfdmlld2VyIiwiYmlsbF9BZHZlcnRpc2VyIl19LCJnaXZlbl9uYW1lIjoiQmlsbCIsInhzLnVzZXIuYXR0cmlidXRlcyI6e30sImZhbWlseV9uYW1lIjoiVGFuZyIsInN1YiI6ImY1ZDQ3ZWU2LWNjODItNDFmZi05ZDg5LWExYjFjZTI1OGI4OCIsInNjb3BlIjpbImJ1bGxldGluYm9hcmQtaTMzMzI0NCF0NDMxLlVwZGF0ZSIsIm9wZW5pZCIsImJ1bGxldGluYm9hcmQtaTMzMzI0NCF0NDMxLkRpc3BsYXkiXSwiY2xpZW50X2lkIjoic2ItYnVsbGV0aW5ib2FyZC1pMzMzMjQ0IXQ0MzEiLCJjaWQiOiJzYi1idWxsZXRpbmJvYXJkLWkzMzMyNDQhdDQzMSIsImF6cCI6InNiLWJ1bGxldGluYm9hcmQtaTMzMzI0NCF0NDMxIiwiZ3JhbnRfdHlwZSI6InBhc3N3b3JkIiwidXNlcl9pZCI6ImY1ZDQ3ZWU2LWNjODItNDFmZi05ZDg5LWExYjFjZTI1OGI4OCIsIm9yaWdpbiI6ImxkYXAiLCJ1c2VyX25hbWUiOiJiaWxsLnRhbmdAc2FwLmNvbSIsImVtYWlsIjoiYmlsbC50YW5nQHNhcC5jb20iLCJhdXRoX3RpbWUiOjE1NTc5NzUzODEsInJldl9zaWciOiI2OTYyNTEwYSIsImlhdCI6MTU1Nzk3NTM4MSwiZXhwIjoxNTU4MDE4NTgxLCJpc3MiOiJodHRwOi8vaTMzMzI0NHRyaWFsLmxvY2FsaG9zdDo4MDgwL3VhYS9vYXV0aC90b2tlbiIsInppZCI6IjA5MzM2NWE0LWM2ZTktNDQxOS04ZjMwLTVlNmVhZTgxNTliOCIsImF1ZCI6WyJzYi1idWxsZXRpbmJvYXJkLWkzMzMyNDQhdDQzMSIsIm9wZW5pZCIsImJ1bGxldGluYm9hcmQtaTMzMzI0NCF0NDMxIl19.Fyzvz2Ac-rllPfXKVm7zTmNKnI_f68du6vYjKfrGCU8f7K-SwhEmm3-l-spkcf4LMFPEdIQGTbHxexpZmFpgKlpQidgzoJsPXRUt47jbDUM7dZ5xe7tLsWEz2g61kcOynMEo0mIuFrkOeiKMPOmn18VxT-aRf5jBLzMIkgyLly1wWjkJy7YzVupu1hHcxmoGhz4XJjYHQxHtzjOMRLzVRS44R0XSRnr1ICg8onLxPbjXclOTqHUv8uMVDCpK8Wd2sx5J4fCJliPowNM1B4uUR4krWbaDj07B6XfDTwlObjbgJhkPc2PUgE7sLOCZO3IyL9kzArCGkPmbk8EJS4tWPsc9ThvgO-GSjJ3dme6pkNrP5-tdhdrqh5HUJs-IfO_QOCxfOxNVH7-_5TpB1AejpH8uUhUJy1W0gUZ5i79yuIqx14BXU_8kZcnSUdv2t7mWqBbFGbmbG5_JGBTL6TRiXNy8gysMEboh6DKY-DrBqCdybZEj5bbJ-QkPxHRR7VadpbEOaexRJWmbKLwOgYFWWiZDQmJNFxZpgI9CaD0nWxkDebHUcW2VQEp1IVWyPcQ_Rtt7GcHA9PE1hHkCDK_teBXaLAFbWyYC3Kd9Ze6SUmc1OBeUNBti4ZLSFnT6MnlgiJyl0AiodmxNctrX6Zxd7zDVMD4ob4fAdNQfBZFWbHY

{ "postgresql-9.3":[ { "name":"postgresql-lite", "label":"postgresql-9.3", "credentials":{ "dbname":"test", "hostname":"127.0.0.1", "password":"test123!", "port":"5432", "uri":"postgres://testuser:test123!@localhost:5432/test", "username":"testuser" }, "tags":[ "relational", "postgresql" ], "plan":"free" } ], "rabbitmq-lite":[ { "credentials":{ "hostname":"127.0.0.1", "password":"guest", "uri":"amqp://guest:guest@127.0.0.1:5672", "username":"guest" }, "label":"rabbitmq-lite", "tags":[ "rabbitmq33", "rabbitmq", "amqp" ] } ], "xsuaa":[ { "credentials":{ "clientid":"bill-demo-client-id", "clientsecret":"bill-demo-clientsecret", "identityzone":"bill-demo-identityzone", "identityzoneid":"bill-demo-identityzoneid", "tenantid":"bill-demo-tenantid", "tenantmode":"shared", "url":"bill-demo-dummy-url", "verificationkey":"-----BEGIN PUBLIC KEY-----MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC1Ms8+eaZ/Af04VtxyxtXydz0PGnGKYWcbPGaCvVUb0Y5KtibykaNfC2zxqS9zwjimIm9PB+9YcDYEo/jhXzY6NIaowvryKR5YfiLPkODMkjFlNQh93o6CGhSrk6hkhJzvGAwQ0Md2uGJ5ZBigpPztvd5l9mptt8mq7e/WPoBylQIDAQAB-----END PUBLIC KEY-----", "xsappname":"bulletinboard-i333244" }, "label":"xsuaa", "name":"uaa-bulletinboard", "plan":"application", "tags":[ "xsuaa" ] } ] }

