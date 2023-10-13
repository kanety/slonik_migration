class CreateTests < ActiveRecord::Migration::Current
  def change
    create_table :test_tables do |t|
      t.text :title
      t.boolean :flag, default: false
    end
  end
end
