document.addEventListener("DOMContentLoaded", function () {
  const splashNav = document.getElementById("splash-nav");

  if (splashNav) {
    window.onscroll = function () {
      if (window.pageYOffset > 450) {
        splashNav.classList.add("scrolled");
      } else {
        splashNav.classList.remove("scrolled");
      }
    };
  }
});
