class AddRoleToEditors < ActiveRecord::Migration[7.0]
  def change
    add_column :editors, :role, :string, null: false, default: "editor"
    add_index  :editors, :role
  end
end
