class AddColumnsMenuIdAndHotelIdInCart < ActiveRecord::Migration[7.0]
  def change
    add_reference :carts, :hotel, foreign_key: { to_table: :users }
    add_reference :carts, :menu, foreign_key: { to_table: :menus }
    add_column :carts, :ordered, :boolean, default: false
    add_column :carts, :ordered_at, :datetime
    add_column :carts, :served, :boolean, default: false
    add_column :carts, :served_at, :datetime
  end
end
