var jwt = require('jsonwebtoken');
var fs = require('fs');
var privateKey = fs.readFileSync('../cmder/rsa_private_unencrypted.pem');
var token = jwt.sign({ foo: 'bar' }, privateKey, { algorithm: 'RS256'});
console.log(token);
