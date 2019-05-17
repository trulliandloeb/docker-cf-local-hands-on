var jwt = require('jsonwebtoken');
var fs = require('fs');
var privateKey = fs.readFileSync('./rsa_private_unencrypted.pem');
jwt.sign({ foo: 'bar' }, privateKey, { algorithm: 'RS256'}, (err, token) => {
	console.log(err);
	console.log("======");
	console.log(token);
});
