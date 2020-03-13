include WebMock::API

WebMock.disable_net_connect!(allow_localhost: true)

WebMock.stub_request(
  :any,
  'https://js.stripe.com/v1/'
).to_return(
  body: File.new(Rails.root + 'spec/fixtures/js.stripe.com-v3').read
)
