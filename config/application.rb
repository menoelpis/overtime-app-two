require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module OvertimeAppKali
  class Application < Rails::Application
  	config.autoload_paths << Rails.root.join("lib")
  end
end
