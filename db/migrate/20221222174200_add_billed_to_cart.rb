class AddBilledToCart < ActiveRecord::Migration[7.0]
  def change
    add_column :carts, :billed, :boolean, default: false
  end
end
