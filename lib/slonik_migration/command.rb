require 'yaml'
require 'shellwords'

module SlonikMigration
  class Command
    def initialize
      @config = SlonikMigration::Config.load
    end

    def execute(sql, options = {})
      command = build(sql, options)
      puts command if ENV['VERBOSE']
      system command
    end

    private

    def build(sql, target: nil, name: nil, owner: nil)
      sql << %Q|; ALTER #{target} "#{name}" OWNER TO #{@config.owner}| if target && name && @config.owner
      command = @config.command.dup
      command.gsub!(%r{\$SQL}) { Shellwords.escape(sql) }
      command.gsub!(%r{\$(\w+)}) { replace($1) }
      command
    end

    def replace(key)
      if (var = @config.variables[key])
        Shellwords.escape(var.to_s)
      else
        "$#{key}"
      end
    end
  end
end
