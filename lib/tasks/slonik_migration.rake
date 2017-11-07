namespace :slonik do
  namespace :db do
    desc "Migrate database using slonik_execute_script"
    task :migrate => :environment do
      SlonikMigration.patch { Rake::Task["db:migrate"].invoke }
    end

    namespace :migrate do
      task :up => :environment do
        SlonikMigration.patch { Rake::Task["db:migrate:up"].invoke }
      end
      task :down => :environment do
        SlonikMigration.patch { Rake::Task["db:migrate:down"].invoke }
      end
    end
  end
end
