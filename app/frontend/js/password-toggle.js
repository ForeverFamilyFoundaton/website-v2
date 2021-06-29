document.addEventListener("DOMContentLoaded", function () {
  const el = document.querySelector(".toggle-password");
  if (el) {
    el.addEventListener("click", (e) => {
      const icon = document.getElementById("password-visibility-toggle");
      const input = document.getElementById("user_password")

      if (input.type == "password") {
        icon.classList.add("fa-eye-slash");
        icon.classList.remove("fa-eye");
        input.type = "text";
      } else {
        icon.classList.remove("fa-eye-slash");
        icon.classList.add("fa-eye");
        input.type = "password";
      }
    });
  }
});
