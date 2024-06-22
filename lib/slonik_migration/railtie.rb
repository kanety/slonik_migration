# frozen_string_literal: true

module SlonikMigration
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/slonik_migration.rake'
    end
  end
end
