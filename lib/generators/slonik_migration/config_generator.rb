require 'rails/generators'

module SlonikMigration
  class ConfigGenerator < Rails::Generators::Base
    source_root File.join(File.dirname(__FILE__), 'templates')

    def create_config_file
      template 'slonik.yml', 'config/slonik.yml'
    end
  end
end
