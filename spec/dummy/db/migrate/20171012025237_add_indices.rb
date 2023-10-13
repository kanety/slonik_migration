class AddIndices < ActiveRecord::Migration::Current
  def change
    add_index :test_tables, :column
  end
end
