require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fileserver
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.middleware.insert 0, Rack::Session::Cookie, secret: "MY_SECRET"

    config.middleware.insert_after Rack::Session::Cookie, Warden::Manager do |manager|

      manager.default_strategies :authentication_token, :basic_auth
      # manager.default_strategies :password, :basic
      manager.failure_app = UnauthorisedController
    end

    ## Reverse Proxy for development purposes
    config.middleware.insert_after Warden::Manager, Rack::ReverseProxy do

      ## Redirect all PHP URLs
      reverse_proxy_options preserve_host: true

      reverse_proxy %r{(.*\.php.*)}, 'http://localhost:80/fileserver/$1'
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
