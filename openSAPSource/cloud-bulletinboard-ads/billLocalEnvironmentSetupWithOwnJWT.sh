echo "Hint: run script with 'source localEnvironmentSetup.sh'"
echo "This script prepares the current shell's environment variables (not permanently)"

# Used for backing services like the PostgreSQL database
export VCAP_APPLICATION={}
export VCAP_SERVICES='{ "postgresql-9.3":[ { "name":"postgresql-lite", "label":"postgresql-9.3", "credentials":{ "dbname":"test", "hostname":"127.0.0.1", "password":"test123!", "port":"5432", "uri":"postgres://testuser:test123!@localhost:5432/test", "username":"testuser" }, "tags":[ "relational", "postgresql" ], "plan":"free" } ], "rabbitmq-lite":[ { "credentials":{ "hostname":"127.0.0.1", "password":"guest", "uri":"amqp://guest:guest@127.0.0.1:5672", "username":"guest" }, "label":"rabbitmq-lite", "tags":[ "rabbitmq33", "rabbitmq", "amqp" ] } ], "xsuaa":[ { "label":"xsuaa", "provider":null, "plan":"application", "name":"uaa-bulletinboard", "tags":[ "xsuaa" ], "instance_name":"uaa-bulletinboard", "binding_name":null, "credentials":{ "uaadomain":"authentication.us30.hana.ondemand.com", "tenantmode":"shared", "sburl":"https://internal-xsuaa.authentication.us30.hana.ondemand.com", "clientid":"sb-bulletinboard-i333244!t431", "verificationkey":"-----BEGIN PUBLIC KEY-----MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC1Ms8+eaZ/Af04VtxyxtXydz0PGnGKYWcbPGaCvVUb0Y5KtibykaNfC2zxqS9zwjimIm9PB+9YcDYEo/jhXzY6NIaowvryKR5YfiLPkODMkjFlNQh93o6CGhSrk6hkhJzvGAwQ0Md2uGJ5ZBigpPztvd5l9mptt8mq7e/WPoBylQIDAQAB-----END PUBLIC KEY-----", "xsappname":"bulletinboard-i333244!t431", "identityzone":"i333244trial", "identityzoneid":"093365a4-c6e9-4419-8f30-5e6eae8159b8", "clientsecret":"SCU3s7F0zGniNgc/bNt7fa71hhc=", "tenantid":"093365a4-c6e9-4419-8f30-5e6eae8159b8", "url":"https://i333244trial.authentication.us30.hana.ondemand.com" }, "syslog_drain_url":null, "volume_mounts":[ ] } ] }'

# Used for dependent service call
export USER_ROUTE=https://opensapcp5userservice.cfapps.eu10.hana.ondemand.com

# Overwrite logging library defaults
export APPENDER=STDOUT
export LOG_APP_LEVEL=TRACE

echo \$VCAP_SERVICES=$VCAP_SERVICES
