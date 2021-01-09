const toggleIt = () => {
  const showInactiveProviders = document.getElementById('show-inactive-providers');
  const activeProviders = document.getElementById('active-providers');
  const inactiveProviders = document.getElementById('inactive-providers');

  inactiveProviders.classList.toggle('d-none');
  activeProviders.classList.toggle('d-none');
  showInactiveProviders.classList.toggle('btn-ghost');
  showInactiveProviders.classList.toggle('btn-main');
}

const changeActiveInactiveProviderView = () => {
  if (document.getElementById('providers-list')) {
    const showInactiveProviders = document.getElementById('show-inactive-providers');
    showInactiveProviders.addEventListener('click', toggleIt)
  };
}

window.addEventListener('turbolinks:load', changeActiveInactiveProviderView)