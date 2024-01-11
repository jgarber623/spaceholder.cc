import config from '@jgarber/eslint-config';

export default [
  ...config,
  {
    files: ['functions/**/*.js'],
    rules: {
      'jsdoc/no-undefined-types': ['error', { definedTypes: ['EventContext'] }]
    }
  },
  {
    files: ['google/**/*.js'],
    languageOptions: {
      globals: {
        require: 'readonly'
      },
      sourceType: 'commonjs'
    }
  }
];
