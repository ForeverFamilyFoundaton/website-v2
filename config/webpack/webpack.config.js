const { webpackConfig } = require("shakapacker");
const { merge } = require("webpack-merge");

// See the shakacode/shakapacker README and docs directory for advice on customizing your webpackConfig.
const customConfig = {
  module: {
    rules: [
      {
        test: require.resolve("jquery"),
        loader: "expose-loader",
        options: {
          exposes: ["$", "jQuery"],
        },
      },
    ],
  },
};
module.exports = merge(webpackConfig, customConfig);
