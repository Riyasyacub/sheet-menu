class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table :tables do |t|
      t.string :name
      t.references :menu
      t.string :waiter_name
      t.string :no_of_seats
      t.index [:menu_id, :name], unique: true
      t.timestamps
    end
  end
end
