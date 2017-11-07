require 'yaml'
require 'shellwords'

module SlonikMigration
  class Command
    def initialize
      config_file = ENV['CONFIG_FILE'] || 'config/slonik.yml'
      env = ENV['RAILS_ENV'] || 'development'
      @config = YAML.load(ERB.new(IO.read(config_file)).result)[env].deep_symbolize_keys
    end

    def execute(sql, options = {})
      command = build(sql, options)
      puts command if ENV['VERBOSE']
      system command
    end

    private

    def build(sql, target: nil, name: nil, owner: nil)
      sql << %Q|; ALTER #{target} "#{name}" OWNER TO #{@config[:owner]}| if target && name && @config[:owner]
      @config[:command].gsub(%r{\$SQL}, Shellwords.escape(sql))
                       .gsub(%r{\$(\w+)}) { replace($1.to_sym) }
    end

    def replace(key)
      if (var = @config.dig(:variables, key))
        Shellwords.escape(var.to_s)
      else
        "$#{key}"
      end
    end
  end
end
