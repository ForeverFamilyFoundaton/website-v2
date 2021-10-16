document.addEventListener("DOMContentLoaded", function () {
  const topNav = document.getElementById("top-nav");

  if (topNav) {
    window.onscroll = function () {
      if (window.pageYOffset > 450) {
        console.log('sh')
        topNav.classList.add("scrolled");
      } else {
        topNav.classList.remove("scrolled");
      }
    };
  }
});
