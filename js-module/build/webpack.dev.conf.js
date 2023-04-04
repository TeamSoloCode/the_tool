/* Development config:
  ========================================================================== */
const webpack = require("webpack");
const path = require("path");

// Source: https://github.com/survivejs/webpack-merge
const { merge } = require("webpack-merge");
// Base config
const baseWebpackConfig = require("./webpack.base.conf");

const devWebpackConfig = merge(baseWebpackConfig, {
  mode: "development",
  devtool: "eval-source-map",
  devServer: {
    port: 8081,
    static: path.resolve(process.cwd(), "dist"),
    compress: false,
    historyApiFallback: true,
    allowedHosts: "all",
    watchFiles: ["src/**/*"],
    magicHtml: false,
    open: false,
  },
  plugins: [
    new webpack.SourceMapDevToolPlugin({
      filename: "[file].map",
    }),
  ],
});

module.exports = new Promise((resolve, reject) => {
  resolve(devWebpackConfig);
});
