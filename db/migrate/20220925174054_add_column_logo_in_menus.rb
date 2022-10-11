class AddColumnLogoInMenus < ActiveRecord::Migration[7.0]
  def change
    add_column :menus, :logo, :string
  end
end
