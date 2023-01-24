class AddColumnsToOrderables < ActiveRecord::Migration[7.0]
  def change
    add_column :orderables, :ordered, :boolean, default: false
    add_column :orderables, :ordered_at, :datetime
    add_column :orderables, :cancelled, :boolean, default: false
    add_column :orderables, :served, :boolean, default: false
    add_column :orderables, :served_at, :datetime
    add_column :orderables, :preparing, :boolean, default: false

    remove_column :carts, :ordered, :boolean
    remove_column :carts, :ordered_at, :datetime
    remove_column :carts, :served, :boolean
    remove_column :carts, :served_at, :datetime
  end
end
