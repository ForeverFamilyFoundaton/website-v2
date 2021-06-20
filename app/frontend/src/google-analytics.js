window.contact_email_click = function () {
  ga("send", "event", {
    eventCategory: "Contact",
    eventAction: "Email",
    eventLabel: "Click",
  });
};

window.donation_click = function () {
  ga("send", "event", {
    eventCategory: "Donate",
    eventAction: "Make a Donation",
    eventLabel: "Click",
  });
};

window.just_give_click = function () {
  ga("send", "event", {
    eventCategory: "Donate",
    eventAction: "Just Give",
    eventLabel: "Click",
  });
};

window.event_register_click = function (name) {
  var str1 = "'send', 'event', { eventCategory: 'Event', eventAction: '";
  var str2 = "', eventLabel: 'Register'}";
  var res = str1.concat(name, str2);
  ga(res);
};

window.personal_membership_register_click = function () {
  ga("send", "event", {
    eventCategory: "Membership",
    eventAction: "Personal",
    eventLabel: "Register",
  });
};

window.business_membership_register_click = function () {
  ga("send", "event", {
    eventCategory: "Membership",
    eventAction: "Business",
    eventLabel: "Register",
  });
};

window.the_sign_registry_click = function () {
  ga("send", "event", {
    eventCategory: "Shopping",
    eventAction: "The Sign Registry",
    eventLabel: "Click",
  });
};

window.igive_click = function () {
  ga("send", "event", {
    eventCategory: "Shopping",
    eventAction: "iGive",
    eventLabel: "Click",
  });
};

window.amazon_click = function () {
  ga("send", "event", {
    eventCategory: "Shopping",
    eventAction: "Amazon",
    eventLabel: "Click",
  });
};

window.love_knows_no_death_selz_click = function () {
  ga("send", "event", {
    eventCategory: "Shopping",
    eventAction: "Love Knows No Death",
    eventLabel: "Selz",
  });
};

window.love_knows_no_death_amazon_click = function () {
  ga("send", "event", {
    eventCategory: "Shopping",
    eventAction: "Love Knows No Death",
    eventLabel: "Amazon",
  });
};

window.in_the_light_selz_click = function () {
  ga("send", "event", {
    eventCategory: "Shopping",
    eventAction: "In The Light",
    eventLabel: "Selz",
  });
};

window.facebook_click = function () {
  ga("send", "event", {
    eventCategory: "Social media",
    eventAction: "Facebook",
    eventLabel: "Click",
  });
};

window.instagram_click = function () {
  ga("send", "event", {
    eventCategory: "Social media",
    eventAction: "Instagram",
    eventLabel: "Click",
  });
};

window.pinterest_click = function () {
  ga("send", "event", {
    eventCategory: "Social media",
    eventAction: "Pinterest",
    eventLabel: "Click",
  });
};

window.linkedin_click = function () {
  ga("send", "event", {
    eventCategory: "Social media",
    eventAction: "LinkedIn",
    eventLabel: "Click",
  });
};

window.twitter_click = function () {
  ga("send", "event", {
    eventCategory: "Social media",
    eventAction: "Twitter",
    eventLabel: "Click",
  });
};

window.youtube_click = function () {
  ga("send", "event", {
    eventCategory: "Social media",
    eventAction: "Youtube",
    eventLabel: "Click",
  });
};

window.store_cart_click = function (product) {
  var str1 = "'send', 'event', { eventCategory: 'Store', eventAction: '";
  var str2 = "', eventLabel: 'Cart'}";
  ga(str1.concat(product, str2));
};

window.volunteer_email_click = function () {
  ga("send", "event", {
    eventCategory: "Volunteer",
    eventAction: "Email",
    eventLabel: "Click",
  });
};
