module.exports = eleventyConfig => {
  eleventyConfig.addPlugin(require('./lib/plugins/sass.js'));

  eleventyConfig
    .addPassthroughCopy('./src/favicon.ico')
    .addPassthroughCopy('./src/robots.txt')
    .addPassthroughCopy('./src/assets/images/spaceholder-180x180.png');

  return {
    dir: {
      input: './src',
      layouts: '_layouts',
      output: './public'
    },

    templateFormats: ['css', 'liquid']
  };
};
