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
    if (error) {
      showCardError(error.message);
    } else {
      showCardError('');
    }
  });

  const form = document.getElementById('new_subscription');
  const customerEmail = $('#customer-email').val();

  form.addEventListener('submit', async (event) => {
    event.preventDefault();
    changeLoadingState(true);

    const result = await stripe.createPaymentMethod({
      type: 'card',
      card: cardElement,
      billing_details: {
        email: customerEmail,
      },
    })

    stripePaymentMethodHandler(result);
  });


  const stripePaymentMethodHandler = async (result) => {
    if (result.error) {
      showCardError(result.error.message);
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
          email: customerEmail,
          payment_method: result.paymentMethod.id
        }),
      });

      // The customer has been created
      const subscription = await res.json();
      confirmSubscription(subscription)
    }
  }

  const confirmSubscription = (subscription) => {
    console.log(subscription)
    const { latest_invoice } = subscription;
    const { payment_intent } = latest_invoice;

    if (payment_intent) {
      const { client_secret, status } = payment_intent;

      if (status === 'requires_action' || status === 'requires_payment_method') {
        stripe.confirmCardPayment(client_secret).then(function(result) {
          if (result.error) {
            // Display error message in your UI.
            // The card was declined (i.e. insufficient funds, card has expired, etc)
            changeLoadingState(false);
            showCardError(result.error.message);
          } else {
            // Show a success message to your customer
            orderComplete(subscription);
          }
        });
      } else {
        // No additional information was needed
        // Show a success message to your customer
        orderComplete(subscription);
      }
    } else {
      orderComplete(subscription);
    }
  }

  const orderComplete = () => {
    $('#new_subscription').hide()
    $('#subscription-success').removeClass('d-none')
  }
});

function showCardError(error) {
  changeLoadingState(false);
  const displayError = $('#card-errors');
  displayError.text(error);
}

// Show a spinner on subscription submission
var changeLoadingState = function(isLoading) {
  if (isLoading) {
    $('button.loading').removeClass('d-none');
    $('input.submit').prop('disabled', true);
  } else {
    $('button.loading').addClass('d-none');
    $('input.submit').prop('disabled', false);
  }
};
