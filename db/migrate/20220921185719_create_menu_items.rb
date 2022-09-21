class CreateMenuItems < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_items do |t|
      t.references :menu, null: false, foreign_key: true
      t.string :category
      t.string :item_name
      t.text :description
      t.float :price
      t.string :image_url

      t.timestamps
    end
  end
end
