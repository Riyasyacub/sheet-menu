class CreateMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :menus do |t|
      t.references :user, null: false, foreign_key: true
      t.string :sheet_key, null: false

      t.timestamps
    end
  end
end
