document.addEventListener("DOMContentLoaded", function () {
  const splashNav = document.getElementById("splash-nav");
  const stickyDonateButton = document.getElementById("sticky-donate-button");
  window.onscroll = function () {
    if (window.pageYOffset > 450) {
      splashNav.classList.add("scrolled");
      // stickyDonateButton.classList.add("scrolled");
    } else {
      splashNav.classList.remove("scrolled");
      // stickyDonateButton.classList.remove("scrolled");
    }
  };
});
