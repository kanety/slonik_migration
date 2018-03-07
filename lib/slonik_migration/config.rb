module SlonikMigration
  class Config
    class << self
      def load
        file = config_file
        env = ENV['RAILS_ENV'] || 'development'
        YAML.load(ERB.new(IO.read(file)).result)[env].deep_symbolize_keys
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
