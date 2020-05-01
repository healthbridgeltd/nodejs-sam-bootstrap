const messages = require('../../../internal/app/hello-world/messages')
let response

/**
 * Hello World
 */
exports.lambdaHandler = async (event, context) => {
  try {
    response = {
      statusCode: 200,
      body: messages.getHelloWorld()
    }
  } catch (err) {
    response = {
      statusCode: 500,
      body: err.message
    }
  }

  return response
}
