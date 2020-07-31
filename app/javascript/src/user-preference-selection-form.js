document.addEventListener("DOMContentLoaded", function () {
  $("form#user-preference-selection-form")
    .find('input[type="checkbox"]')
    .change(function () {
      if (confirm("Update your preferences?")) {
        $(this).closest("form").submit();
      }
    });
});
