import cssnano from 'cssnano';
import postcssNesting from 'postcss-nesting';

export default {
  plugins: [postcssNesting, cssnano]
};
