import CodeMirror from "codemirror/lib/codemirror.js";
import "codemirror/lib/codemirror.css";
import "css/codemirror-overrides.scss";
import "codemirror/mode/gfm/gfm.js";
import "codemirror/addon/selection/active-line.js";

document.addEventListener("DOMContentLoaded", function () {
  const editors = document.querySelectorAll("textarea.markdown");

  editors.forEach((elm) => {
    CodeMirror.fromTextArea(elm, {
      mode: "gfm",
      lineNumbers: true,
      lineWrapping: true,
      styleActiveLine: true,
    });
  });
});
