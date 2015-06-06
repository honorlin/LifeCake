class RenameLivesTagsToTagsAll < ActiveRecord::Migration
  def change
    rename_column :lives, :tags, :tags_all
  end
end
