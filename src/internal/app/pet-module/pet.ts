interface Pet {
  id: number
  name: string
  status: string
}

const pet: Pet = {
  id: 1,
  name: 'Dog',
  status: 'available'
}

const getPetById = (): Pet => pet

export default {
  getPetById
}
