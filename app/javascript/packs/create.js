
import Create from '../create.svelte';
$(document).on('DOMContentLoaded', function() {
// document.addEventListener("DOMContentLoaded", () => {
  const create = new Create({
    target: document.body,
    props: {
    }
  });
  window.app = create;
})
// function loaded() {
//   const create = new Create({
//     target: document.body,
//     props: {
//     }
//   });
//   window.app = create;

//   console.log("DOM loaded")
// }

// if (document.readyState === 'loading') {
//   document.addEventListener('DOMContentLoaded', loaded);
// } else {
//   loaded();
// }
