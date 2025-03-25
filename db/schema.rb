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

ActiveRecord::Schema[8.0].define(version: 2025_03_25_211232) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "abc_keys", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.string "account_type", null: false
    t.text "description"
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "number"
    t.index ["account_type"], name: "index_accounts_on_account_type"
    t.index ["number"], name: "index_accounts_on_number", unique: true
    t.index ["parent_id"], name: "index_accounts_on_parent_id"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "address_type", null: false
    t.string "country_code", null: false
    t.string "format_type", null: false
    t.string "street_address_1"
    t.string "street_address_2"
    t.string "city"
    t.string "state_province"
    t.string "postal_code"
    t.string "attention"
    t.string "company_name"
    t.string "district"
    t.string "subdivision"
    t.string "building_name"
    t.string "floor_number"
    t.string "room_number"
    t.string "post_office_box"
    t.string "phone"
    t.string "email"
    t.boolean "is_default", default: false
    t.text "notes"
    t.string "addressable_type", null: false
    t.bigint "addressable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id", "address_type"], name: "index_addresses_on_addressable_and_type"
    t.index ["addressable_type", "addressable_id", "is_default"], name: "index_addresses_on_addressable_and_default"
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable"
    t.index ["country_code"], name: "index_addresses_on_country_code"
    t.index ["format_type"], name: "index_addresses_on_format_type"
  end

  create_table "auto_lot_issue_methods", force: :cascade do |t|
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

  create_table "financial_report_statuses", force: :cascade do |t|
    t.string "report_type", null: false
    t.string "period_type", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.string "status", null: false
    t.integer "version", null: false
    t.text "error_message"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "report_date", null: false
    t.index ["completed_at"], name: "index_financial_report_statuses_on_completed_at"
    t.index ["report_date"], name: "index_financial_report_statuses_on_report_date"
    t.index ["report_type", "period_type", "start_date", "end_date", "version"], name: "idx_financial_report_statuses_unique_report", unique: true
    t.index ["report_type", "status"], name: "idx_financial_report_statuses_type_status"
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
    t.bigint "auto_lot_issue_method_id"
    t.bigint "storage_condition_id"
    t.decimal "default_lot_size", precision: 10, scale: 2
    t.index ["abc_key_id"], name: "index_items_on_abc_key_id"
    t.index ["auto_lot_issue_method_id"], name: "index_items_on_auto_lot_issue_method_id"
    t.index ["commodity_key_id"], name: "index_items_on_commodity_key_id"
    t.index ["eccn_key_id"], name: "index_items_on_eccn_key_id"
    t.index ["order_method_id"], name: "index_items_on_order_method_id"
    t.index ["price_group_id"], name: "index_items_on_price_group_id"
    t.index ["product_key_id"], name: "index_items_on_product_key_id"
    t.index ["storage_condition_id"], name: "index_items_on_storage_condition_id"
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
    t.string "sales_order_number", default: -> { "nextval('sales_order_number_seq'::regclass)" }
    t.string "order_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "customer_id", null: false
    t.decimal "price", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "quantity", default: 0, null: false
    t.index ["customer_id"], name: "index_sales_orders_on_customer_id"
  end

  create_table "storage_conditions", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "track_serial_lots", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.date "date", null: false
    t.text "description"
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.bigint "account_id", null: false
    t.string "transaction_type", null: false
    t.string "reference_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["date"], name: "index_transactions_on_date"
    t.index ["reference_number"], name: "index_transactions_on_reference_number", unique: true
    t.index ["transaction_type"], name: "index_transactions_on_transaction_type"
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

  add_foreign_key "accounts", "accounts", column: "parent_id"
  add_foreign_key "items", "auto_lot_issue_methods"
  add_foreign_key "items", "commodity_keys"
  add_foreign_key "items", "eccn_keys"
  add_foreign_key "items", "item_subtypes"
  add_foreign_key "items", "item_types"
  add_foreign_key "items", "order_methods"
  add_foreign_key "items", "price_groups"
  add_foreign_key "items", "product_keys"
  add_foreign_key "items", "storage_conditions"
  add_foreign_key "items", "track_serial_lots"
  add_foreign_key "sales_orders", "customers"
  add_foreign_key "transactions", "accounts"
end
