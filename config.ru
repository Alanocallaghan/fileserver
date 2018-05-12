# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

use Rack::ReverseProxy do
  reverse_proxy %r{(.*\.php.*)}, 'http://localhost/fileserver/public/$1'
end

run Rails.application
