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

ActiveRecord::Schema[8.0].define(version: 2025_03_23_131639) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "abc_keys", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "auto_lot_tracking_methods", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "commodity_keys", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "customer_key"
    t.string "customer_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "eccn_keys", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_eccn_keys_on_name", unique: true
  end

  create_table "item_subtypes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "item_key"
    t.string "upc_key"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "item_type_id"
    t.integer "item_subtype_id"
    t.string "stock_unit", default: "kg"
    t.string "purchase_unit", default: "kg"
    t.string "sales_unit", default: "kg"
    t.string "production_unit", default: "kg"
    t.string "order_method"
    t.bigint "order_method_id"
    t.bigint "price_group_id"
    t.bigint "product_key_id"
    t.bigint "commodity_key_id"
    t.bigint "abc_key_id"
    t.bigint "eccn_key_id"
    t.integer "physical_count_days"
    t.string "manufacturer_code"
    t.boolean "purchaseable", default: false, null: false
    t.boolean "saleable", default: false, null: false
    t.integer "height"
    t.integer "width"
    t.integer "length"
    t.integer "weight"
    t.bigint "track_serial_lot_id"
    t.bigint "auto_lot_tracking_method_id"
    t.index ["abc_key_id"], name: "index_items_on_abc_key_id"
    t.index ["auto_lot_tracking_method_id"], name: "index_items_on_auto_lot_tracking_method_id"
    t.index ["commodity_key_id"], name: "index_items_on_commodity_key_id"
    t.index ["eccn_key_id"], name: "index_items_on_eccn_key_id"
    t.index ["order_method_id"], name: "index_items_on_order_method_id"
    t.index ["price_group_id"], name: "index_items_on_price_group_id"
    t.index ["product_key_id"], name: "index_items_on_product_key_id"
    t.index ["track_serial_lot_id"], name: "index_items_on_track_serial_lot_id"
  end

  create_table "order_methods", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "price_groups", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_keys", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchase_orders", force: :cascade do |t|
    t.string "purchase_order_number"
    t.string "order_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales_orders", force: :cascade do |t|
    t.string "sales_order_number"
    t.string "order_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "track_serial_lots", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "items", "auto_lot_tracking_methods"
  add_foreign_key "items", "commodity_keys"
  add_foreign_key "items", "eccn_keys"
  add_foreign_key "items", "item_subtypes"
  add_foreign_key "items", "item_types"
  add_foreign_key "items", "order_methods"
  add_foreign_key "items", "price_groups"
  add_foreign_key "items", "product_keys"
  add_foreign_key "items", "track_serial_lots"
end
