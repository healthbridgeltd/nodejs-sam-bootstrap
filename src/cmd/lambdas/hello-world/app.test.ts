import messages from '@/internal/app/hello-world/messages'
import app from './app'

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
