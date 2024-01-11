import cssnano from 'cssnano';
import postcssNesting from 'postcss-nesting';

export default {
  map: 'inline',
  plugins: [postcssNesting, cssnano]
};
