class AddIndices < ActiveRecord::Migration[5.0]
  def change
    add_index :test_tables, :column
  end
end
