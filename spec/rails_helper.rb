# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'

require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'webmock'
require "paperclip/matchers"
require "support/devise"
require 'support/fixtures'
require 'support/js_drivers'
require 'support/faker'
require 'support/devise'
require 'support/capybara-host'
require 'support/sidekiq'
require 'support/factory_bot'
require 'support/helpers'
require 'support/shoulda_matchers'
require 'support/webmock-vcr'
require 'support/stripe_helpers'
require 'support/test_data'
Dir[Rails.root.join('spec/shared/context/*.rb')].each do |context|
  require context
end

Rails.root.join('db/data').glob('**/*.rb').each(&method(:require))

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
end
