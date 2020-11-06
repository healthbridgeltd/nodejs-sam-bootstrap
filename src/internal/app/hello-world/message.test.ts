import sut from './messages'

describe('helloWorldMessage', () => {
  it('Should return hello world', async () => {
    const result = sut.getHelloWorld()

    expect(result).toBe('Hello, World!')

    expect(typeof result).toBe('string')
  })
})
