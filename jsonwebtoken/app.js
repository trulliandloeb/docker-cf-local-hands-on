var jwt = require('jsonwebtoken');
var fs = require('fs');
var payload = require('./payload.json');

payload.auth_time = payload.iat = Math.floor(Date.now() / 1000);

var privateKey = fs.readFileSync('./bill_private.pem');
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
