'use strict'

exports.handler = handler

// Event uses the format descibred here
// http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-set-up-simple-proxy.html?shortFooter=true#api-gateway-simple-proxy-for-lambda-input-format

function handler (event, context, callback) {
  context.callbackWaitsForEmptyEventLoop = false
  console.log('Received event:', JSON.stringify(event, null, 2), JSON.stringify(context, null, 2))


  // output follows the format described here
  // http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-set-up-simple-proxy.html?shortFooter=true#api-gateway-simple-proxy-for-lambda-output-format
  var response = {
    statusCode: 200,
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      message: 'hello lambda',
      path: event.path
    })
  }

  callback(null, response)
}
