import Cookies from "js-cookie";

document.addEventListener("DOMContentLoaded", function () {
  const announcement = document.getElementById("announcement");

  if (announcement) {
    const closeLink = announcement.querySelector("a.close");
    const key = ["announcement", announcement.dataset.id].join("-");

    console.log(key);
    if (Cookies.get(key) != undefined) {
      announcement.style.display = "none";
    } else {
      closeLink.addEventListener("click", () => {
        Cookies.set(key, true);
        announcement.style.display = "none";
      });
    }
  }
});
