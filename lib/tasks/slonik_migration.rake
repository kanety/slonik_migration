# frozen_string_literal: true

require 'slonik_migration/config'
require 'slonik_migration/extension'

if SlonikMigration::Config.load.enabled
  namespace :slonik do
    task :migration do
      SlonikMigration::Extension.overwrite
    end
  end

  Rake::Task["db:migrate"].enhance(["slonik:migration"]) do 
    SlonikMigration::Extension.restore
  end

  Rake::Task["db:migrate:up"].enhance(["slonik:migration"]) do 
    SlonikMigration::Extension.restore
  end

  Rake::Task["db:migrate:down"].enhance(["slonik:migration"]) do 
    SlonikMigration::Extension.restore
  end
end

namespace :slonik do
  namespace :db do
    desc "Migrate database using slonik_execute_script"
    task :migrate => :environment do
      Rake::Task["db:migrate"].invoke
    end

    namespace :migrate do
      task :up => :environment do
        Rake::Task["db:migrate:up"].invoke
      end
      task :down => :environment do
        Rake::Task["db:migrate:down"].invoke
      end
    end
  end
end
