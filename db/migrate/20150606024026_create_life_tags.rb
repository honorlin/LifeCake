class CreateLifeTags < ActiveRecord::Migration
  def change
    create_table :life_tags do |t|
      t.integer :life_id
      t.integer :tag_id

      t.timestamps null: false
    end
  end
end
