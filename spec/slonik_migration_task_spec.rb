describe SlonikMigration do
  it 'slonik:db:migrate' do
    Rake::Task['slonik:db:migrate'].invoke
  end

  it 'slonik:db:migrate:down' do
    ENV['VERSION'] = '20171012025237'
    Rake::Task['slonik:db:migrate:down'].invoke
  end

  it 'slonik:db:migrate:up' do
    ENV['VERSION'] = '20171012025237'
    Rake::Task['slonik:db:migrate:up'].invoke
  end
end
