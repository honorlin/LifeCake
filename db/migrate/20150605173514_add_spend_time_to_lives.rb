class AddSpendTimeToLives < ActiveRecord::Migration
  def change
    add_column :lives, :spend_time, :integer
  end
end
