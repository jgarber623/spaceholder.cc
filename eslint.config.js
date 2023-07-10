const config = require('@jgarber/eslint-config');
const globals = require('globals');

module.exports = [
  ...config,
  {
    languageOptions: {
      globals: {
        ...globals.node
      }
    }
  },
  {
    files: ['netlify/**/*.js'],
    languageOptions: {
      sourceType: 'module'
    }
  }
];
