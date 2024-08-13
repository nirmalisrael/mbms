/**
 * UI Toasts
 */

'use strict';

(function () {
    // Bootstrap toasts example
    // --------------------------------------------------------------------
    const toastPlacementExample = document.querySelector('.toast-placement-ex'),
        toastPlacementBtn = document.querySelector('#showToastPlacement');
    let selectedType, selectedPlacement, toastPlacement;

    // Dispose toast when open another
    function toastDispose(toast) {
        if (toast && toast._element !== null) {
            if (toastPlacementExample) {
                toastPlacementExample.classList.remove(selectedType);
                DOMTokenList.prototype.remove.apply(toastPlacementExample.classList, selectedPlacement);
            }
            toast.dispose();
        }
    }
    // Placement Button click
    if (toastPlacementBtn) {
        toastPlacementBtn.onclick = function () {
            if (toastPlacement) {
                toastDispose(toastPlacement);
            }
            selectedType = document.querySelector('#selectTypeOpt').value;
            selectedPlacement = document.querySelector('#selectPlacement').value.split(' ');

            toastPlacementExample.classList.add(selectedType);
            DOMTokenList.prototype.add.apply(toastPlacementExample.classList, selectedPlacement);
            toastPlacement = new bootstrap.Toast(toastPlacementExample);
            toastPlacement.show();
        };
    }
})();

// ui-toasts.js
'use strict';

(function () {
    const toastElement = document.querySelector('.toast-message');
    console.log("outside method");

    window.showToast = function (message, type, iconClass, title) {
        console.log("inside method");

        if (toastElement) {
            console.log("inside if");
            toastElement.querySelector('.toast-body').innerText = message;
            toastElement.classList.add(type);

            const iconElement = toastElement.querySelector('.toast-header i');
            const titleElement = toastElement.querySelector('.toast-header .me-auto');

            iconElement.className = iconClass;  // Update icon class
            titleElement.innerText = title;     // Update title text
            console.log("before toast");
            var toast = new bootstrap.Toast(toastElement);
            console.log("after toast");

            toast.show();
        }
    };
})();
