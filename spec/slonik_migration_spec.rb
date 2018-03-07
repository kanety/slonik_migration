describe SlonikMigration do
  it 'has a version number' do
    expect(SlonikMigration::VERSION).not_to be nil
  end

  it 'db:migrate' do
    Rake::Task['db:migrate'].invoke
  end

  it 'db:migrate:down' do
    ENV['VERSION'] = '20171012025237'
    Rake::Task['db:migrate:down'].invoke
  end

  it 'db:migrate:up' do
    ENV['VERSION'] = '20171012025237'
    Rake::Task['db:migrate:up'].invoke
  end
end
