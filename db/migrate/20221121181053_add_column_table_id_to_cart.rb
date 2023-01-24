class AddColumnTableIdToCart < ActiveRecord::Migration[7.0]
  def change
    add_reference :carts, :table, foreign_key: { to_table: :tables}
    remove_reference :carts, :menu
  end
end
