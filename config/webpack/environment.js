const { environment } = require('@rails/webpacker')
const svelte = require('./loaders/svelte')

environment.loaders.prepend('svelte', svelte)

const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery'
  })
)
module.exports = environment