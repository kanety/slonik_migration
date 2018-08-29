class CreateTests < ActiveRecord::Migration[5.0]
  def change
    create_table :test_tables do |t|
      t.text :title
      t.boolean :flag, default: false
    end
  end
end
