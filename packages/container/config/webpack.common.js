const HtmlWebpackPlugin = require('html-webpack-plugin');


module.exports = {
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/, // .js and .jsx files
        exclude: /node_modules/, // excluding the node_modules folder
        use: {
          loader: 'babel-loader',
          options: {
            presets: [
              '@babel/preset-react', // it is to jsx tags
              '@babel/preset-env' // transform the code of different ways. take ES6, ES7 ... so on and convert to ES5
            ],
            plugins: [
              '@babel/plugin-transform-runtime' // add more syntax such as async await 
            ]
          }
        }
      },
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: './public/index.html',
      filename: 'index.html'
    })
  ]
};

