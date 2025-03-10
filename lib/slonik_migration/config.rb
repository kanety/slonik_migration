# frozen_string_literal: true

module SlonikMigration
  class Config
    attr_accessor :enabled, :owner, :command, :variables

    def initialize(hash)
      hash.each do |key, val|
        send("#{key}=", val) if respond_to?("#{key}=")
      end
    end

    class << self
      def load
        hash = load_file
        Config.new(hash).freeze
      end

      private

      def load_file
        file = config_file
        if File.exist?(file)
          load_yaml(file).fetch(ENV['RAILS_ENV'] || 'development', {})
        else
          {}
        end
      end

      def load_yaml(file)
        yaml = ERB.new(IO.read(file)).result
        if Gem::Version.new(Psych::VERSION) >= Gem::Version.new("4.0")
          YAML.load(yaml, aliases: true)
        else
          YAML.load(yaml)
        end
      end

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
