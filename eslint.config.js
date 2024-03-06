import config from "@jgarber/eslint-config";

export default [
  ...config,
  {
    files: ["functions/**/*.js"],
    rules: {
      "jsdoc/no-undefined-types": ["error", { definedTypes: ["EventContext"] }],
    },
  },
];
