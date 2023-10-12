const config = require('@jgarber/eslint-config');

module.exports = [
  ...config,
  {
    files: ['functions/**/*.js'],
    languageOptions: {
      globals: {
        Response: 'readonly',
        fetch: 'readonly'
      },
      sourceType: 'module'
    },
    rules: {
      'jsdoc/no-undefined-types': ['error', { definedTypes: ['EventContext'] }]
    }
  }
];
