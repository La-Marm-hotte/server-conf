const observeDOM = (function(){
  const MutationObserver = window.MutationObserver || window.WebKitMutationObserver;

  return function( obj, callback ){
    if( !obj || obj.nodeType !== 1 ) return; 

    if( MutationObserver ){
      // define a new observer
      const mutationObserver = new MutationObserver(callback)

      // have the observer observe foo for changes in children
      mutationObserver.observe( obj, { childList:true, subtree:true })
      return mutationObserver
    }
    
    // browser support fallback
    else if( window.addEventListener ){
      obj.addEventListener('DOMNodeInserted', callback, false)
      obj.addEventListener('DOMNodeRemoved', callback, false)
    }
  }
})();

var hasChanged = false;

function onChange() {
  if (hasChanged) return;

  const btn = document.querySelector('a[routerlink="/sso"]');
  if (btn) {
    btn.href = '#/sso?identifier=example-org';

    const card = document.querySelector('app-login .card-body');
    if (card) {
      const form = document.querySelector('app-login .card-body .form-group');
      const checkbox = document.createElement('input');
      checkbox.setAttribute('type', 'checkbox');
      checkbox.setAttribute('id', 'toggle');
      const label = document.createElement('label');
      label.setAttribute('for', 'toggle');
      label.setAttribute('class', 'toggle-admin-connect');
      const text = document.createTextNode('Connexion');
      label.appendChild(text);
      card.insertBefore(label, form);
      card.insertBefore(checkbox, label);

      hasChanged = true;
    }
  }
}

document.addEventListener("DOMContentLoaded", function(event) {
  observeDOM(document.querySelector('body'), function(m) {
    onChange();
  });
});

const orgId = window.localStorage.getItem('ssoOrgIdentifier');
if (orgId != '"example-org"') {
  window.localStorage.setItem('ssoOrgIdentifier', '"example-org"');
}
