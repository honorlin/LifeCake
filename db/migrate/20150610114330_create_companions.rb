class CreateCompanions < ActiveRecord::Migration
  def change
    create_table :companions do |t|
      t.integer :user_id
      t.string :name
      t.integer :count
      t.datetime :last_use_time

      t.timestamps null: false
    end
  end
end
