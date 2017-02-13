# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170213153143) do

  create_table "addresses", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.string   "city",       limit: 255
    t.string   "zip_code",   limit: 255
    t.string   "street",     limit: 255
    t.string   "email",      limit: 255
    t.integer  "order_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "addresses", ["order_id"], name: "index_addresses_on_order_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.decimal  "unit_price",             precision: 10
    t.integer  "quantity",   limit: 4
    t.integer  "order_id",   limit: 4
    t.string   "item_name",  limit: 255
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id", using: :btree
  add_index "line_items", ["product_id"], name: "index_line_items_on_product_id", using: :btree

  create_table "order_transitions", force: :cascade do |t|
    t.string   "to_state",    limit: 255,   null: false
    t.text     "metadata",    limit: 65535
    t.integer  "sort_key",    limit: 4,     null: false
    t.integer  "order_id",    limit: 4,     null: false
    t.boolean  "most_recent"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "order_transitions", ["order_id", "most_recent"], name: "index_order_transitions_parent_most_recent", unique: true, using: :btree
  add_index "order_transitions", ["order_id", "sort_key"], name: "index_order_transitions_parent_sort", unique: true, using: :btree

  create_table "orders", force: :cascade do |t|
    t.text     "comment",          limit: 65535
    t.integer  "shipping_type_id", limit: 4
    t.decimal  "shipping_cost",                  precision: 10
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "orders", ["shipping_type_id"], name: "index_orders_on_shipping_type_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.text     "description",      limit: 65535
    t.text     "long_description", limit: 65535
    t.string   "photo",            limit: 255
    t.decimal  "price",                          precision: 10
    t.integer  "category_id",      limit: 4
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree

  create_table "shipping_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.decimal  "cost",                   precision: 10
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_foreign_key "line_items", "orders"
  add_foreign_key "line_items", "products"
  add_foreign_key "orders", "shipping_types"
  add_foreign_key "products", "categories"
end
