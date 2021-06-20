require("@rails/ujs").start();
require("@rails/activestorage").start();
require("channels");

import "@fortawesome/fontawesome-pro/js/all.js";
// import "bootstrap";
import 'js/bootstrap.js'
import "src/stripe";
import "src/password-toggle";
import "src/user-preference-selection-form";
import "src/nav-fade";
import "src/announcement";
import "src/google-analytics";

document.addEventListener("DOMContentLoaded", function () {
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();
});
