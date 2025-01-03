import postcssPlugin from "@jgarber/eleventy-plugin-postcss";

import manifest from "./src/manifest.webmanifest.json" with { type: "json" };

export default function(eleventyConfig) {
  // Global Data
  eleventyConfig.addGlobalData("app", manifest);

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
}

export const config = {
  dir: {
    input: "./src",
  },
};
