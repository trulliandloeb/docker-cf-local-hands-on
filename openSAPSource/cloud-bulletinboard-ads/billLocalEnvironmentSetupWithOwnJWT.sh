echo "Hint: run script with 'source localEnvironmentSetup.sh'"
echo "This script prepares the current shell's environment variables (not permanently)"

# Used for backing services like the PostgreSQL database
export VCAP_APPLICATION={}
export VCAP_SERVICES='{ "postgresql-9.3":[ { "name":"postgresql-lite", "label":"postgresql-9.3", "credentials":{ "dbname":"test", "hostname":"127.0.0.1", "password":"test123!", "port":"5432", "uri":"postgres://testuser:test123!@localhost:5432/test", "username":"testuser" }, "tags":[ "relational", "postgresql" ], "plan":"free" } ], "rabbitmq-lite":[ { "credentials":{ "hostname":"127.0.0.1", "password":"guest", "uri":"amqp://guest:guest@127.0.0.1:5672", "username":"guest" }, "label":"rabbitmq-lite", "tags":[ "rabbitmq33", "rabbitmq", "amqp" ] } ], "xsuaa":[ { "credentials":{ "clientid":"bill-demo-client-id", "clientsecret":"bill-demo-clientsecret", "identityzone":"bill-demo-identityzone", "identityzoneid":"bill-demo-identityzoneid", "tenantid":"bill-demo-tenantid", "tenantmode":"shared", "url":"bill-demo-dummy-url", "verificationkey":"-----BEGIN PUBLIC KEY-----MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC1Ms8+eaZ/Af04VtxyxtXydz0PGnGKYWcbPGaCvVUb0Y5KtibykaNfC2zxqS9zwjimIm9PB+9YcDYEo/jhXzY6NIaowvryKR5YfiLPkODMkjFlNQh93o6CGhSrk6hkhJzvGAwQ0Md2uGJ5ZBigpPztvd5l9mptt8mq7e/WPoBylQIDAQAB-----END PUBLIC KEY-----", "xsappname":"bulletinboard-i333244" }, "label":"xsuaa", "name":"uaa-bulletinboard", "plan":"application", "tags":[ "xsuaa" ] } ] }'

# Used for dependent service call
export USER_ROUTE=https://opensapcp5userservice.cfapps.eu10.hana.ondemand.com

# Overwrite logging library defaults
export APPENDER=STDOUT
export LOG_APP_LEVEL=TRACE

echo \$VCAP_SERVICES=$VCAP_SERVICES
