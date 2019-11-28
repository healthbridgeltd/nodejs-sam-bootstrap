module.exports = {
  roots: [
    '<rootDir>/src/'
  ],
  testEnvironment: 'node',
  verbose: true,
  // Coverage options
  collectCoverageFrom: [
    'src/cmd/**/*.js',
    '!src/cmd/**/*.test.js'
  ],
  coverageDirectory: 'build/coverage'
}
