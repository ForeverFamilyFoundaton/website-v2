require("@rails/ujs").start();
require("@rails/activestorage").start();
require("channels");

import "@fortawesome/fontawesome-pro/js/all.js";
// import "bootstrap";
import 'js/bootstrap.js'
import "js/password-toggle";
import "js/user-preference-selection-form";
import "js/nav-fade";
import "js/announcement";
import "js/google-analytics";

document.addEventListener("DOMContentLoaded", function () {
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();
});
