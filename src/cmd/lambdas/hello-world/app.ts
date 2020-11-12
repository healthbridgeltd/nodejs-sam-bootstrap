import messages from '@/internal/app/hello-world/messages'

let response

/**
 * Hello World
 */
export const lambdaHandler = async (): Promise<{
  statusCode: number
  body: string
}> => {
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

export default {
  lambdaHandler
}
