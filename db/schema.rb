# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_10_05_132933) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menu_items", force: :cascade do |t|
    t.bigint "menu_id", null: false
    t.string "category"
    t.string "item_name"
    t.text "description"
    t.float "price"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id", "item_name"], name: "index_menu_items_on_menu_id_and_item_name", unique: true
    t.index ["menu_id"], name: "index_menu_items_on_menu_id"
  end

  create_table "menus", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "sheet_key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "logo"
    t.index ["user_id"], name: "index_menus_on_user_id"
  end

  create_table "orderables", force: :cascade do |t|
    t.bigint "menu_item_id", null: false
    t.bigint "cart_id", null: false
    t.integer "qty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_orderables_on_cart_id"
    t.index ["menu_item_id"], name: "index_orderables_on_menu_item_id"
  end

  create_table "tables", force: :cascade do |t|
    t.string "name"
    t.bigint "menu_id"
    t.string "waiter_name"
    t.string "no_of_seats"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id", "name"], name: "index_tables_on_menu_id_and_name", unique: true
    t.index ["menu_id"], name: "index_tables_on_menu_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "menu_items", "menus"
  add_foreign_key "menus", "users"
  add_foreign_key "orderables", "carts"
  add_foreign_key "orderables", "menu_items"
end
