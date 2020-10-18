'use strict';

const pointsToFile = uri => /\/[^/]+\.[^/]+$/.test(uri);
const hasTrailingSlash = uri => uri.endsWith('/');
const needsTrailingSlash = uri => !pointsToFile(uri) && !hasTrailingSlash(uri);


exports.handler = (event, context, callback) => {
    const request = event.Records[0].cf.request;
    const event_url = request.uri;
    const qs = request.querystring;

    if (needsTrailingSlash(event_url)) {
            return callback(null, {
                body: '',
                status: '301',
                headers: {
                location: [{
                    key: 'Location',
                    value: qs ? `${event_url}/?${qs}` : `${event_url}/`,
                }],
                }
            });
        }
        else {
        var newuri = event_url.replace(/\/$/, '\/index.html');
        request.uri = newuri;
        }
callback(null, request);
};

