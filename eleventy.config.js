import fs from "node:fs/promises";

import postcssPlugin from "@jgarber/eleventy-plugin-postcss";

export default async function(eleventyConfig) {
  // Global Data
  eleventyConfig.addGlobalData("app", JSON.parse(await fs.readFile("./src/manifest.webmanifest.json")));

  // Passthrough File Copy
  eleventyConfig
    .addPassthroughCopy("./src/_headers")
    .addPassthroughCopy("./src/*.{ico,txt}")
    .addPassthroughCopy("./src/assets/images")
    .addPassthroughCopy({
      "./src/manifest.webmanifest.json": "manifest.webmanifest",
    });

  // Plugins
  eleventyConfig.addPlugin(postcssPlugin);

  return {
    dir: {
      input: "./src",
    },
  };
}
