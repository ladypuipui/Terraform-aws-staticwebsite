'use strict';

exports.handler = (event, context, callback) => {

    const allowIp = [ALLOWIP];

    // Get request and request headers   
    const request = event.Records[0].cf.request;
    const headers = request.headers;
    const clientIp = request.clientIp;
    const isallowIp = allowIp.includes(clientIp);

    // Configure authentication
    const authUser = 'BASICUSER';
    const authPass = 'BASICPASS';

    // Construct the Basic Auth string
    const authString = 'Basic ' + new Buffer(authUser + ':' + authPass).toString('base64');

    if (isallowIp) {
        return callback(null, request);
    }

    else
    if (typeof headers.authorization == 'undefined' || headers.authorization[0].value != authString) {
        const body = 'Unauthorized';
        const response = {
            status: '401',
            statusDescription: 'Unauthorized',
            body: body,
            headers: {
                'www-authenticate': [{ key: 'WWW-Authenticate', value: 'Basic realm="Please Enter Your Password"' }]
            },
        };

        return callback(null, response);

    }
    else{
        return callback(null, request);
    }
};

