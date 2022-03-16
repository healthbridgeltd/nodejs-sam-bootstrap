import sut from './pet'

describe('getPetById', () => {
  it('Should return pet object', async () => {
    const result = sut.getPetById()

    expect(JSON.stringify(result)).toBe('{"id":1,"name":"Dog","status":"available"}')

    expect(typeof result).toBe('object')
  })
})
