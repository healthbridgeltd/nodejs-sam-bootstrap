import messages from '@/internal/app/pet-module/pet'
import app from './app'

describe('get-pet', () => {
  it('Should return pet object', async () => {
    const spy = jest.spyOn(messages, 'getPetById')

    const result = await app.lambdaHandler()

    expect(JSON.stringify(result.body)).toBe('{"id":1,"name":"Dog","status":"available"}')

    expect(typeof result).toBe('object')

    expect(spy).toHaveBeenCalled()

    expect(result.statusCode).toBe(200)
  })
})
