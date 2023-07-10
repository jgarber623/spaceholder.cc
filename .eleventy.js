module.exports = eleventyConfig => {
  // Passthrough File Copy
  eleventyConfig
    .addPassthroughCopy('./src/*.{ico,txt}')
    .addPassthroughCopy('./src/assets/images');

  // Plugins
  eleventyConfig.addPlugin(require('./lib/plugins/postcss.js'));

  return {
    dir: {
      input: './src',
      layouts: '_layouts',
      output: './public'
    }
  };
};
