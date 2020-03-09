"use strict";

var applib = applib || {};

applib = class Core {

    static removeAspNetCheckboxWrapper(elementId) {
        // ASP.NET's checkbox control puts a span tag wrapper around
        // the checkbox. This wrapper disturbs correct Bootstrap 
        // checkbox behavior. This function removes that wrapper for 
        // a given checkbox element. 

        const wrappedElement = document.querySelector(elementId);
        const elementToRemove = wrappedElement.parentNode;

        const checkboxToMove = document.createDocumentFragment();
        checkboxToMove.appendChild(wrappedElement);
        // ASP.NET also moved this class name. This puts it back.
        wrappedElement.classList.add('form-check-input');
        elementToRemove.parentNode.replaceChild(checkboxToMove, elementToRemove);
    }
}



