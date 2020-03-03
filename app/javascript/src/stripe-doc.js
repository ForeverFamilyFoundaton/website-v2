$(function() {

  var stripe;
  const publicKey = $('meta[name=stripe-public-key]').attr("content");

  var stripeElements = function(publicKey) {
    stripe = Stripe(publicKey);
    var elements = stripe.elements();

    // Element styles
    var style = {
      base: {
        fontSize: '16px',
        color: '#32325d',
        fontFamily:
          '-apple-system, BlinkMacSystemFont, Segoe UI, Roboto, sans-serif',
        fontSmoothing: 'antialiased',
        '::placeholder': {
          color: 'rgba(0,0,0,0.4)'
        }
      }
    };

    var card = elements.create('card', { style: style });

    card.mount('#card-element');

    // Element focus ring
    card.on('focus', function() {
      var el = document.getElementById('card-element');
      el.classList.add('focused');
    });

    card.on('blur', function() {
      var el = document.getElementById('card-element');
      el.classList.remove('focused');
    });

    $('#submit').addEventListener('click', function(evt) {
      evt.preventDefault();
      changeLoadingState(true);
      // Initiate payment
      createPaymentMethodAndCustomer(stripe, card);
    });
  };

  function showCardError(error) {
    changeLoadingState(false);
    // The card was declined (i.e. insufficient funds, card has expired, etc)
    var errorMsg = $('.sr-field-error');
    errorMsg.textContent = error.message;
    setTimeout(function() {
      errorMsg.textContent = '';
    }, 8000);
  }

  var createPaymentMethodAndCustomer = function(stripe, card) {
    var cardholderEmail = $('#email').value;
    stripe
      .createPaymentMethod('card', card, {
        billing_details: {
          email: cardholderEmail
        }
      })
      .then(function(result) {
        if (result.error) {
          showCardError(result.error);
        } else {
          createCustomer(result.paymentMethod.id, cardholderEmail);
        }
      });
  };

  async function createCustomer(paymentMethod, cardholderEmail) {
    return fetch('/create-customer', {
      method: 'post',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        email: cardholderEmail,
        payment_method: paymentMethod
      })
    })
      .then(response => {
        return response.json();
      })
      .then(subscription => {
        handleSubscription(subscription);
      });
  }

  function handleSubscription(subscription) {
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
            showCardError(result.error);
          } else {
            // Show a success message to your customer
            confirmSubscription(subscription.id);
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

  function confirmSubscription(subscriptionId) {
    return fetch('/subscription', {
      method: 'post',
      headers: {
        'Content-type': 'application/json'
      },
      body: JSON.stringify({
        subscriptionId: subscriptionId
      })
    })
      .then(function(response) {
        return response.json();
      })
      .then(function(subscription) {
        orderComplete(subscription);
      });
  }

  /* ------- Post-payment helpers ------- */

  /* Shows a success / error message when the payment is complete */
  var orderComplete = function(subscription) {
    changeLoadingState(false);
    var subscriptionJson = JSON.stringify(subscription, null, 2);
    $('.payment-view').forEach(function(view) {
      view.classList.add('hidden');
    });
    $('.completed-view').forEach(function(view) {
      view.classList.remove('hidden');
    });
    $('.order-status').textContent = subscription.status;
    $('code').textContent = subscriptionJson;
  };

  // Show a spinner on subscription submission
  var changeLoadingState = function(isLoading) {
    if (isLoading) {
      $('#spinner').classList.add('loading');
      $('button').disabled = true;

      $('#button-text').classList.add('hidden');
    } else {
      $('button').disabled = false;
      $('#spinner').classList.remove('loading');
      $('#button-text').classList.remove('hidden');
    }
  };

  stripeElements(publicKey);
});
