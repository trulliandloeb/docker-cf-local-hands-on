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
