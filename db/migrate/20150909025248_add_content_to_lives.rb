class AddContentToLives < ActiveRecord::Migration
  def change
    add_column :lives, :content, :text
  end
end
