# Part2

cf service-keys postgreSQLv9.4-dev
cf create-service-key postgreSQLv9.4-dev access-key
cf service-key postgreSQLv9.4-dev access-key

https://docs.cloudfoundry.org/devguide/deploy-apps/ssh-services.html

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

