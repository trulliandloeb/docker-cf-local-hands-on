var jwt = require('jsonwebtoken');
var fs = require('fs');
var payload = require('./payload.json');
var now = Math.floor(Date.now() / 1000);
payload.auth_time = payload.iat = now;

var privateKey = fs.readFileSync('./rsa_private_unencrypted.pem');
jwt.sign(payload, privateKey, {
	algorithm: 'RS256',
	expiresIn: "1h",
	header: {
		jku: "https://i333244trial.authentication.us30.hana.ondemand.com/token_keys",
		kid: "key-id-1"
	}
}, (err, token) => {
	console.log(err);
	console.log("======");
	console.log(token);
});