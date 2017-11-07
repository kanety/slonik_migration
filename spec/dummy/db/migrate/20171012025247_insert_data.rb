class InsertData < ActiveRecord::Migration[5.1]
  def up
    execute "insert into test_tables (title) values ('test')"
  end
end
