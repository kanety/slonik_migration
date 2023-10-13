class InsertData < ActiveRecord::Migration::Current
  def up
    execute "insert into test_tables (title) values ('test')"
  end
end
