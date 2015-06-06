class CreateLives < ActiveRecord::Migration
  def change
    create_table :lives do |t|
      t.integer :user_id
      t.datetime :start_time
      t.datetime :end_time
      t.string :description
      t.string :tags
      t.string :location
      t.string :companion

      t.timestamps null: false
    end
  end
end
