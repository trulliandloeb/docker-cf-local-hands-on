echo "Hint: run script with 'source localEnvironmentSetup.sh'"
echo "This script prepares the current shell's environment variables (not permanently)"

# Used for backing services like the PostgreSQL database
export VCAP_APPLICATION={}
export VCAP_SERVICES='{ "postgresql-9.3":[ { "name":"postgresql-lite", "label":"postgresql-9.3", "credentials":{ "dbname":"test", "hostname":"127.0.0.1", "password":"test123!", "port":"5432", "uri":"postgres://testuser:test123!@localhost:5432/test", "username":"testuser" }, "tags":[ "relational", "postgresql" ], "plan":"free" } ], "rabbitmq-lite":[ { "credentials":{ "hostname":"127.0.0.1", "password":"guest", "uri":"amqp://guest:guest@127.0.0.1:5672", "username":"guest" }, "label":"rabbitmq-lite", "tags":[ "rabbitmq33", "rabbitmq", "amqp" ] } ], "xsuaa":[ { "binding_name":null, "credentials":{ "clientid":"sb-bulletinboard-i333244!t431", "clientsecret":"SCU3s7F0zGniNgc/bNt7fa71hhc=", "identityzone":"i333244trial", "identityzoneid":"093365a4-c6e9-4419-8f30-5e6eae8159b8", "sburl":"https://internal-xsuaa.authentication.us30.hana.ondemand.com", "tenantid":"093365a4-c6e9-4419-8f30-5e6eae8159b8", "tenantmode":"shared", "uaadomain":"authentication.us30.hana.ondemand.com", "url":"https://i333244trial.authentication.us30.hana.ondemand.com", "verificationkey":"-----BEGIN PUBLIC KEY-----MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA5+N6Qb8hPfDCxKiFUCW5P3WSOk2BGMc+hBO0qyqaPhHDT7N8LlaGX7u5KvNh0f3eloMBtxMo/ZgF5yxCrvin4G/9fFG6C61EJ4QV2qbNmi8l8X2LyTBGSgLggYKZItq9pfDJdId3AaXjGeQBBcAgvfUimGoynvwuK/hnCx8JQhLGa+7C20srJfKv1/n3jZ/sfVSvJ0nm8joeRzaJrh5i9Wu+ewcB05cZ8xR2sLlKehO+TSCrStVh1hYUAu0uycDThTSHSaXi+1zc0N+SPJXM/1PVMJzENAaB0gWq1TNElOgdc5L1Fmo5vjNUc/on9Qg9v70A+meQsJgC5xx5rihNCstVJUS2sikTRL91Qmjv/XpweUV9vZpZTJ61ELBsxMPJAsLW9kVcon49YnIG/0EzJLyPxKo4bcd7ZqJxLQkIWqzH9XAPhu4GQtnMY5NWcrkU0dKabpbIbQ8ThyOe9rpluCQvjdSYXNzeIwxFy/mETtyn3ro7wSFqc3w143UuQgw7N8/1pyVGu1dojStsw1fiz754vAH2P2xrNzmfVTvcHyImbCUWStz0wsLMvCjtJZ86XF5XUQKmybYX+0GFgdYgu1dzBYI+NOUvDDPGDkTa47eOGwljKS2cvRtPdAXXc+3l3AsBQyld1KlH+v//rgtgg2n2Czbxw4N+34y/FTrYso8CAwEAAQ==-----END PUBLIC KEY-----", "xsappname":"bulletinboard-i333244!t431" }, "instance_name":"uaa-bulletinboard", "label":"xsuaa", "name":"uaa-bulletinboard", "plan":"application", "provider":null, "syslog_drain_url":null, "tags":[ "xsuaa" ], "volume_mounts":[ ] } ] }'

# Used for dependent service call
export USER_ROUTE=https://opensapcp5userservice.cfapps.eu10.hana.ondemand.com

# Overwrite logging library defaults
export APPENDER=STDOUT
export LOG_APP_LEVEL=TRACE

echo \$VCAP_SERVICES=$VCAP_SERVICES
