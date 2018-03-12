require 'ostruct'

module SlonikMigration
  class Config
    class << self
      def load
        file = config_file
        env = ENV['RAILS_ENV'] || 'development'

        hash = if File.exist?(file)
                 YAML.load(ERB.new(IO.read(file)).result)[env]
               else
                 {}
               end
        OpenStruct.new(hash).freeze
      end

      private

      def config_file
        if ENV['CONFIG_FILE']
          ENV['CONFIG_FILE']
        elsif defined?(Rails)
          Rails.root.join('config/slonik.yml').to_s
        else
          File.join(Dir.pwd, 'config/slonik.yml')
        end
      end
    end
  end
end
