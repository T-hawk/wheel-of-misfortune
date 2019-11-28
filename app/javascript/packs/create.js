import Create from '../create.svelte'

document.addEventListener('DOMContentLoaded', () => {
  const create = new Create({
    target: document.body,
    props: {
    }
  });

  window.app = create;
})