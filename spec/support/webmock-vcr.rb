require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

driver_hosts = Webdrivers::Common.subclasses.map do |driver|
  URI(driver.base_url).host
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.ignore_localhost = true
  config.configure_rspec_metadata!
  config.ignore_hosts(*driver_hosts)
end

RSpec.configure do |config|
  config.around(:each) do |example|
    network = example.metadata[:network]

    if network
      WebMock.disable!
      VCR.turned_off { example.run }
      WebMock.enable!
      next
    else
      example.run
    end
  end
end
