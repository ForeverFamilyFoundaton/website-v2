$(document).ready(() => {
  if ($("#card-element").length) {
    setupStripe();
  }
  let newCard = $("#use-new-card");
  if (newCard.length) {
    newCard.click((e) => {
      e.preventDefault();
      $("#payment-form").removeClass("d-none");
      $("#existing-card-form").addClass("d-none");
    });
  }
});

function setupStripe() {
  console.log("setup stripe");
  const stripe_key = $("meta[name=stripe-public-key]").attr("content");
  const stripe = Stripe(stripe_key);
  const elements = stripe.elements();
  const card = elements.create("card");
  card.mount("#card-element");

  var displayError = $("#card-errors");

  card.on("change", (event) => {
    if (event.error) {
      displayError.text(event.error.message);
    } else {
      displayError.text("");
    }
  });

  const form = $("#payment-form");
  let paymentIntentId = form.data("payment-intent");
  let setupIntentId = form.data("setup-intent");

  if (paymentIntentId) {
    console.log("first paymentIntentId : 37");
    if (form.data("status") == "requires_action") {
      stripe
        .confirmCardPayment(paymentIntentId, {
          setup_future_usage: "off_session",
        })
        .then((result) => {
          if (result.error) {
            displayError.text(result.error.message);
            form.find("#card-details").removeClass("d-none");
          } else {
            form.get(0).submit();
          }
        });
    }
  }

  form.submit((event) => {
    console.log("form submit : 55");
    event.preventDefault();
    let name = form.find("#name-on-card").val();
    let payment_data = {
      payment_method_data: {
        card: card,
        billing_details: {
          name: name,
        },
      },
    };

    // Complete a payment intent
    if (paymentIntentId) {
      console.log("paymentIntentId : 69");
      stripe
        .confirmCardPayment(paymentIntentId, {
          payment_method: payment_data.payment_method_data,
          setup_future_usage: "off_session",
          save_payment_method: true,
        })
        .then((result) => {
          console.log("result");
          console.log(result);

          if (result.error) {
            displayError.text(result.error.message);
            form.find("#card-details").removeClass("d-none");
          } else {
            console.log(result.payment_method);
            // Need to store this on the server....
            addHiddenField(form, "payment_method_id", result.payment_method);
            form.get(0).submit();
          }
        });
    } else if (setupIntentId) {
      console.log("else if setupIntentId : 90");

      stripe
        .confirmCardSetup(setupIntentId, {
          payment_method: payment_data.payment_method_data,
        })
        .then((result) => {
          if (result.error) {
            displayError.text(result.error.message);
          } else {
            addHiddenField(
              form,
              "payment_method_id",
              result.setupIntent.payment_method
            );
            form.get(0).submit();
          }
        });
    } else {
      console.log("else : 109");

      payment_data.payment_method_data.type = "card";
      stripe
        .createPaymentMethod(payment_data.payment_method_data)
        .then((result) => {
          if (result.error) {
            displayError.text(result.error.message);
          } else {
            addHiddenField(form, "payment_method_id", result.paymentMethod.id);
            form.get(0).submit();
          }
        });
    }
    // Subscribing with no trial
  });
}

function addHiddenField(form, name, value) {
  $("<input />")
    .attr({
      type: "hidden",
      name: name,
      value: value,
    })
    .appendTo(form);
}
