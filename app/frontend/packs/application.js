import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "@fortawesome/fontawesome-pro/js/all.js";
import "bootstrap"
import "../js/password-toggle";
import "../js/user-preference-selection-form";
import "../js/nav-fade";
import "../js/announcement";
import "../js/google-analytics";
