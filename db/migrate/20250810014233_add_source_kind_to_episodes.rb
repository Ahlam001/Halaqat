class AddSourceKindToEpisodes < ActiveRecord::Migration[7.0]
  def change
    add_column :episodes, :source_kind, :string
  end
end
