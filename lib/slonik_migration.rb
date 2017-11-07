require 'slonik_migration/version'
require 'slonik_migration/railtie' if defined?(Rails)

module SlonikMigration
  class << self
    def patch
      overwrite
      yield
    ensure
      restore
    end

    def overwrite
      ActiveRecord::Migrator.class_eval do
        private
        alias_method :orig_use_transaction?, :use_transaction?
        def use_transaction?(migration)
          false
        end
      end

      ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.class_eval do
        alias_method :orig_execute, :execute
        def execute(sql, name = nil)
          require 'slonik_migration/command'
          if sql =~ /^create (table|sequence|view) "([^"]+)"/i
            ret = SlonikMigration::Command.new.execute(sql, target: $1, name: $2)
            raise "failed to execute slonik command." unless ret
          elsif sql =~ /^(create|alter|drop)/i
            ret = SlonikMigration::Command.new.execute(sql)
            raise "failed to execute slonik command." unless ret
          else
            orig_execute sql, name
          end
        end
      end
    end

    def restore
      ActiveRecord::Migrator.class_eval do
        alias_method :use_transaction?, :orig_use_transaction?
      end

      ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.class_eval do
        alias_method :execute, :orig_execute
      end
    end
  end
end
