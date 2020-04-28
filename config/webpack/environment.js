const { environment } = require('@rails/webpacker')

// Jquery setup.
const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Rails: '@rails/ujs'
  })
)
const config = environment.toWebpackConfig()
config.resolve.alias = {
  jquery: "jquery/src/jquery"
}

module.exports = environment
