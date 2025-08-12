class CreateEpisodes < ActiveRecord::Migration[7.0]
  def change
    create_table :episodes do |t|
      t.string   :title,           null: false
      t.text     :description
      t.integer  :duration, null: true
      t.datetime :published_at,     null: true
      t.string   :source_url,       null: false
      t.string   :thumbnail_url,    null: true

      t.references :editor, null: true, foreign_key: true, index: true

      t.timestamps
    end

    # فهارس للبحث والترتيب
    add_index :episodes, :title
    add_index :episodes, :published_at
    add_index :episodes, :source_url, unique: true

    reversible do |dir|
      dir.up do
        execute <<~SQL
          ALTER TABLE episodes
          ADD CONSTRAINT duration_non_negative CHECK (duration IS NULL OR duration >= 0);
        SQL
      end
    end
  end
end
