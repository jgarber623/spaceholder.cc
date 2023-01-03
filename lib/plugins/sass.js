const path = require('node:path');
const sass = require('sass');

module.exports = eleventyConfig => {
  eleventyConfig.addTemplateFormats('scss');

  eleventyConfig.addExtension('scss', {
    outputFileExtension: 'css',

    compile: (inputContent, inputPath) => {
      const parsed = path.parse(inputPath);

      if (parsed.name.startsWith('_')) {
        return;
      }

      const result = sass.compileString(inputContent, {
        loadPaths: [
          parsed.dir || '.',
          'node_modules'
        ]
      });

      return () => result.css;
    }
  });
};
