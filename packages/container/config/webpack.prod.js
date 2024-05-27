const { merge } = require('webpack-merge');
const ModuleFederationPlugin = require('webpack/lib/container/ModuleFederationPlugin');
const commonConfig = require('./webpack.common');
const packageJson = require('../package.json');

const domain = process.env.PRODUCTION_DOMAIN;

const prodConfig = {
  mode: 'production',
  output: {
    // this template because cash questions
    filename: '[name].[contenthash].js',
    publicPath: '/container/latest/' // in the s3 to access the files that are in bucket/container/latest, need from this

  },
  plugins: [
    new ModuleFederationPlugin({
      name: 'container',
      remotes: {
        marketing: `marketing@${domain}/marketing/latest/remoteEntry.js`
      },
      shared: packageJson.dependencies,
    })
  ]
}

module.exports = merge(commonConfig, prodConfig);