document.addEventListener("DOMContentLoaded", function () {
  form = document.getElementById("user-preference-selection-form");

  if (form) {
    const checkBoxes = form.querySelectorAll('input[type="checkbox"]')

    checkBoxes.forEach(el => el.addEventListener('click', event => {
      confirm("Update your preferences?") && form.submit()
    }));
  }
});
