import pet from '@/internal/app/pet-module/pet'

let response

/**
 * Get Pet By ID
 */
export const lambdaHandler = async (): Promise<{
  statusCode: number
  body: string
}> => {
  try {
    response = {
      statusCode: 200,
      body: JSON.stringify(pet.getPetById())
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
