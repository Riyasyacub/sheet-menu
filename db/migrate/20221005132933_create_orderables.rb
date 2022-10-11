class CreateOrderables < ActiveRecord::Migration[7.0]
  def change
    create_table :orderables do |t|
      t.belongs_to :menu_item, null: false, foreign_key: true
      t.belongs_to :cart, null: false, foreign_key: true
      t.integer :qty

      t.timestamps
    end
  end
end
