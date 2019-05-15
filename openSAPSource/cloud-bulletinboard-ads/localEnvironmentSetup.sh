echo "Hint: run script with 'source localEnvironmentSetup.sh'"
echo "This script prepares the current shell's environment variables (not permanently)"

# Used for backing services like the PostgreSQL database
export VCAP_APPLICATION={}
export VCAP_SERVICES='{"postgresql-9.3":[{"name":"postgresql-lite","label":"postgresql-9.3","credentials":{"dbname":"test","hostname":"127.0.0.1","password":"test123!","port":"5432","uri":"postgres://testuser:test123!@localhost:5432/test","username":"testuser"},"tags":["relational","postgresql"],"plan":"free"}],"rabbitmq-lite":[{"credentials":{"hostname":"127.0.0.1","password":"guest","uri":"amqp://guest:guest@127.0.0.1:5672","username":"guest"},"label":"rabbitmq-lite","tags":["rabbitmq33","rabbitmq","amqp"]}]}'

# Used for dependent service call
export USER_ROUTE=https://opensapcp5userservice.cfapps.eu10.hana.ondemand.com

# Overwrite logging library defaults
export APPENDER=STDOUT
export LOG_APP_LEVEL=TRACE

echo \$VCAP_SERVICES=$VCAP_SERVICES
