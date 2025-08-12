class AddCategoryToEpisodes < ActiveRecord::Migration[7.0]
  def change
    add_column :episodes, :category, :string, null: false, default: "other"
    add_index :episodes, :category
  end
end
