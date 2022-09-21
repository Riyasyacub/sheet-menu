class AddTitleToMenu < ActiveRecord::Migration[7.0]
  def change
    add_column :menus, :title, :string
  end
end
