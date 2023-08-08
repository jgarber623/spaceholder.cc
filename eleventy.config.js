module.exports = function(eleventyConfig) {
  // Global Data
  eleventyConfig.addGlobalData('app', require('./src/manifest.webmanifest.json'));

  // Passthrough File Copy
  eleventyConfig
    .addPassthroughCopy('./src/*.{ico,txt}')
    .addPassthroughCopy('./src/assets/images')
    .addPassthroughCopy({
      './src/manifest.webmanifest.json': 'manifest.webmanifest'
    });

  // Plugins
  eleventyConfig.addPlugin(require('./lib/plugins/postcss.js'));

  return {
    dir: {
      input: './src'
    }
  };
};
