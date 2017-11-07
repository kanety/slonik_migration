class CreateTests < ActiveRecord::Migration[5.1]
  def change
    create_table :test_tables do |t|
      t.text :title
    end
  end
end
