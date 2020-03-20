require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module ForeverFamilyFoundation
  class Application < Rails::Application
    config.load_defaults 6.0

    config.i18n.default_locale = :en
    config.generators do |g|
      g.test_framework :rspec, views: false
      g.helper false
      g.assets false
      g.helper_specs false
      g.view_specs false
    end
  end
end
