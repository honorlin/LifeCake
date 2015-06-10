class CreateLifeCompanions < ActiveRecord::Migration
  def change
    create_table :life_companions do |t|
      t.integer :life_id
      t.integer :companion_id

      t.timestamps null: false
    end
  end
end
