var jwt = require('jsonwebtoken');
var fs = require('fs');
var payload = require('./payload.json');
var privateKey = fs.readFileSync('./rsa_private_unencrypted.pem');
jwt.sign(payload, privateKey, {
	algorithm: 'RS256',
	expiresIn: "1h",
	header: {
		jku: "bill-demo-jku"
	}
}, (err, token) => {
	console.log(err);
	console.log("======");
	console.log(token);
});