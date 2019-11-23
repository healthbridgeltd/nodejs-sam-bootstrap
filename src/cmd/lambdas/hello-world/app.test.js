const app = require('./app.js')
const messages = require('../../../internal/app/hello-world/messages')

const context = {}
const event = {}

describe('helloWorld', () => {
  it('Should return hello world', async () => {
    const spy = jest.spyOn(messages, 'getHelloWorld')

    const result = await app.lambdaHandler(event, context)

    expect(result.body).toBe('Hello, World!')

    expect(typeof result).toBe('object')

    expect(spy).toHaveBeenCalled()

    expect(result.statusCode).toBe(200)
  })
})
