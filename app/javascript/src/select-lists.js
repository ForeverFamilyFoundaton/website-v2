import SlimSelect from "slim-select";
document.addEventListener("DOMContentLoaded", function () {
  var select_lists = document.querySelector(".js-select");
  if (select_lists) {
    new SlimSelect({
      select: ".js-select",
    });
  }
});
import "slim-select/src/slim-select/slimselect.scss";
