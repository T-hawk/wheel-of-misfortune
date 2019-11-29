/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_svelte' %> (and
// <%= stylesheet_pack_tag 'hello_svelte' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Svelte!</div> at the bottom of the page.


// document.addEventListener('turbolinks:load', () => {
import Game from '../app.svelte'
// $(document).on('load turbolinks:load', function() {
document.addEventListener("DOMContentLoaded", () => {
  const game = new Game({
    target: document.body,
    props: {
    }
  });

  window.app = game;
})

