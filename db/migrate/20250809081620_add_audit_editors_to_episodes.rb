class AddAuditEditorsToEpisodes < ActiveRecord::Migration[7.0]
  def change
    add_reference :episodes, :created_by_editor,
                  foreign_key: { to_table: :editors },
                  index: true,
                  null: true

    add_reference :episodes, :updated_by_editor,
                  foreign_key: { to_table: :editors },
                  index: true,
                  null: true
  end
end
