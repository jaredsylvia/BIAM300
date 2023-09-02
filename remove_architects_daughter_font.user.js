// ==UserScript==
// @name         Remove Architects Daughter Font
// @namespace    http://www.yetanotherjared.com/
// @version      1.0
// @description  Remove 'Architects Daughter' font-family from style attributes on devryu.instructure.com
// @author       Jared Sylvia
// @match        https://devryu.instructure.com/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    // Function to remove 'Architects Daughter' font-family from style attributes
    function removeArchitectsDaughterFont() {
        const elementsWithStyle = document.querySelectorAll('*[style*="font-family: \'Architects Daughter\'"]');
        for (const element of elementsWithStyle) {
            // Replace 'Architects Daughter' with an empty string in the style attribute
            const style = element.getAttribute('style');
            if (style) {
                element.setAttribute('style', style.replace(/font-family:\s*'Architects Daughter',?/gi, ''));
            }
        }
    }

    // Run the function when the page loads
    window.addEventListener('load', removeArchitectsDaughterFont);
})();
