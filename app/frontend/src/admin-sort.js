import Sortable from "sortablejs";
import axios from "axios";

document.addEventListener("DOMContentLoaded", function () {
  var el = document.querySelector("#index_table_splash_nav_items tbody");
  if (el) {
    const token = $('meta[name="csrf-token"]').attr("content");

    var sortable = new Sortable(el, {
      draggable: ".splash-nav-item",
      handle: ".drag-handle",
      onEnd: function (evt) {
        const itemEl = evt.item;
        const id = itemEl.id.split("_").pop();
        axios({
          headers: {
            "X-CSRF-Token": token,
          },
          method: "put",
          url: `/admin/splash_nav_items/${id}/reorder`,
          data: {
            new_position: evt.newDraggableIndex,
          },
        });
      },
    });
  }
});
