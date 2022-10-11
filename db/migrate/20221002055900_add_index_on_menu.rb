class AddIndexOnMenu < ActiveRecord::Migration[7.0]
  def change
    add_index :menu_items, [:menu_id, :item_name], unique: true
  end
end
