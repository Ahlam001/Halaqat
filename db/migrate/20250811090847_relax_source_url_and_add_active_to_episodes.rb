class RelaxSourceUrlAndAddActiveToEpisodes < ActiveRecord::Migration[7.0]
  def change
    change_column_null :episodes, :source_url, true

    remove_index :episodes, :source_url, if_exists: true
    add_index :episodes, :source_url, unique: true, where: "source_url IS NOT NULL", name: "index_episodes_on_source_url_unique_not_null"

    add_column :episodes, :active, :boolean, null: false, default: true
    add_index  :episodes, :active
  end
end
