const path = require('path');
const webpack = require('webpack');
const UglifyJSPlugin = require('uglifyjs-webpack-plugin');

module.exports = (options) => ({
  mode: options.mode,
  entry: options.entry,
  output: {
    path: path.resolve(process.cwd(), 'build'),
    filename: '[name].js',
  },

  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: [
          {
            loader: 'ts-loader',
            options: {
              transpileOnly: true,
            },
          },
        ],
        exclude: /node_modules/,
      },
      {
        test: /\.jsx?$/, // Transform all .js and .jsx files required somewhere with Babel
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
        },
      },
      {
        // Preprocess our own .css files
        // This is the place to add your own loaders (e.g. sass/less etc.)
        // for a list of loaders, see https://webpack.js.org/loaders/#styling
        test: /\.scss$/,
        exclude: /node_modules/,
        use: ['style-loader', 'css-loader', 'sass-loader'],
      },
      {
        // Preprocess 3rd party .css files located in node_modules
        test: /\.css$/,
        include: /node_modules/,
        use: ['style-loader', 'css-loader'],
      },
      {
        test: /\.ogg$/,
        exclude: /node_modules/,
        loader: 'file-loader',
      },
      {
        test: /\.svg$/,
        use: [
          {
            loader: 'svg-url-loader',
            options: {
              // Inline files smaller than 10 kB
              limit: 10 * 1024,
              noquotes: true,
            },
          },
        ],
      },
      {
        test: /\.(png|jpe?g|gif)$/i,
        use: [
          {
            loader: 'url-loader',
            options: {
              limit: 0.1 * 1024,
            },
          },
        ],
      },
      {
        test: /\.html$/,
        use: 'html-loader',
      },
      {
        test: /\.(mp4|webm)$/,
        use: {
          loader: 'url-loader',
          options: {
            limit: 10000,
          },
        },
      },
    ],
  },
  plugins: options.plugins.concat([
    // Always expose NODE_ENV to webpack, in order to use `process.env.NODE_ENV`
    // inside your code for any environment checks; Terser will automatically
    // drop any unreachable code.
    new UglifyJSPlugin(),
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': 'production',
    }),
  ]),
  resolve: {
    alias: {
      // CSS Imports
      index: path.resolve(process.cwd(), 'src/styles/index.scss'),

      // React Imports
      components: path.resolve(process.cwd(), 'src/components/'),
      modules: path.resolve(process.cwd(), 'src/modules/'),
      stores: path.resolve(process.cwd(), 'src/stores/'),
      submodules: path.resolve(process.cwd(), 'src/submodules/'),
      utils: path.resolve(process.cwd(), 'src/utils/'),
      layouts: path.resolve(process.cwd(), 'src/layouts/'),
    },
    modules: ['src', 'node_modules'],
    extensions: ['.js', '.jsx', '.ts', '.tsx', '.react.js'],
  },
});
