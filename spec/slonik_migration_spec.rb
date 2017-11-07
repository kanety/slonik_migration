describe SlonikMigration do
  before {
    ENV['CONFIG_FILE'] = Rails.root.join('config/slonik.yml').to_s
    ENV['VERBOSE'] = 'true'
  }

  it 'has a version number' do
    expect(SlonikMigration::VERSION).not_to be nil
  end

  context 'rake tasks' do
    it 'runs slonik:db:migrate' do
      Rake::Task['slonik:db:migrate'].invoke
    end

    it 'runs slonik:db:migrate:down' do
      ENV['VERSION'] = '20171012025237'
      Rake::Task['slonik:db:migrate:down'].invoke
    end

    it 'runs slonik:db:migrate:up' do
      ENV['VERSION'] = '20171012025237'
      Rake::Task['slonik:db:migrate:up'].invoke
    end
  end
end
