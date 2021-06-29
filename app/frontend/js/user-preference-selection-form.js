document.addEventListener("DOMContentLoaded", function () {
  form = document.getElementById("user-preference-selection-form");

  form.querySelector('input[type="checkbox"]').addEventListener('change', function() {
    if (confirm("Update your preferences?")) {
      form.submit();
    }
  });
});
