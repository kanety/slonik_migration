require_relative 'boot'

# Pick the frameworks you want:
require "active_record/railtie"

Bundler.require(*Rails.groups)
require "slonik_migration"

module Dummy
  class Application < Rails::Application
  end
end
