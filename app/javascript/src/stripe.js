$(function() {
  const stripe_public_key = $('meta[name=stripe-public-key]').attr("content");
  const stripe = Stripe(stripe_public_key);
  let elements = stripe.elements();

  const style = {
    base: {
      lineHeight: '18px',
      fontSize: '16px',
    }
  };
  const cardElement = elements.create('card', { style: style });
  // Add an instance of the card Element into the `card-element` <div>.
  cardElement.mount('#card-element');

  // show errors
  cardElement.addEventListener('change', ({error}) => {
    const displayError = $('#card-errors');
    if (error) {
      displayError.text(error.message);
    } else {
      displayError.text('');
    }
  });

  const form = document.getElementById('new_subscription');

  form.addEventListener('submit', async (event) => {
    event.preventDefault();

    const result = await stripe.createPaymentMethod({
      type: 'card',
      card: cardElement,
      billing_details: {
        email: 'jenny.rosen@example.com',
      },
    })

    stripePaymentMethodHandler(result);
  });


  const stripePaymentMethodHandler = async (result) => {
    if (result.error) {
      const displayError = $('#card-errors');
      displayError.text(error.message);
    } else {
      // Otherwise send paymentMethod.id to your server
      const token = $('meta[name="csrf-token"]').attr('content');
      const res = await fetch('/subscriptions', {
        method: 'post',
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': token
        },
        body: JSON.stringify({
          email: 'jenny.rosen@example.com',
          payment_method: result.paymentMethod.id
        }),
      });

      // The customer has been created
      const subscription = await res.json();
      confirmSubscription(subscription)
    }
  }

  const confirmSubscription = (subscription) => {
    const { latest_invoice } = subscription;
    const { payment_intent } = latest_invoice;

    if (payment_intent) {
      const { client_secret, status } = payment_intent;

      if (status === 'requires_action') {
        stripe.confirmCardPayment(client_secret).then(function(result) {
          if (result.error) {
            const displayError = $('#card-errors');
            displayError.text(result.error.message);
            // Display error message in your UI.
            // The card was declined (i.e. insufficient funds, card has expired, etc)
          } else {
            // Show a success message to your customer
            $('#new_subscription').hide()
            $('#subscription-success').removeClass('d-none')
          }
        });
      } else {
        // No additional information was needed
        // Show a success message to your customer
        $('#new_subscription').hide()
        $('#subscription-success').removeClass('d-none')
      }
    }
  }
});
