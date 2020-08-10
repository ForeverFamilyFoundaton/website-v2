// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("@rails/activestorage").start();
require("channels");

import "bootstrap";
import "src/stripe";
import "src/password-toggle";
import "src/user-preference-selection-form";

document.addEventListener("DOMContentLoaded", function () {
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();
});

import "@fortawesome/fontawesome-pro/js/all.js";
