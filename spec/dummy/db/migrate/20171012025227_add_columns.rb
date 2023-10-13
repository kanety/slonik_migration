class AddColumns < ActiveRecord::Migration::Current
  def change
    add_column :test_tables, :column, :text
  end
end
