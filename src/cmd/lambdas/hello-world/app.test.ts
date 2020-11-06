import app from './app'
import messages from '../../../internal/app/hello-world/messages'

describe('helloWorld', () => {
  it('Should return hello world', async () => {
    const spy = jest.spyOn(messages, 'getHelloWorld')

    const result = await app.lambdaHandler()

    expect(result.body).toBe('Hello, World!')

    expect(typeof result).toBe('object')

    expect(spy).toHaveBeenCalled()

    expect(result.statusCode).toBe(200)
  })
})
