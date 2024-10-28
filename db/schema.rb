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

ActiveRecord::Schema.define(version: 2024_10_26_074043) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bids", force: :cascade do |t|
    t.bigint "carrier_id", null: false
    t.bigint "shipping_route_id", null: false
    t.bigint "load_type_id", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["carrier_id"], name: "index_bids_on_carrier_id"
    t.index ["load_type_id"], name: "index_bids_on_load_type_id"
    t.index ["shipping_route_id"], name: "index_bids_on_shipping_route_id"
  end

  create_table "carriers", force: :cascade do |t|
    t.string "company_name", null: false
  end

  create_table "data_migrations", primary_key: "version", id: :string, force: :cascade do |t|
  end

  create_table "load_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "shipping_routes", force: :cascade do |t|
    t.string "origin", null: false
    t.string "destination", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["origin", "destination"], name: "index_shipping_routes_on_origin_and_destination", unique: true
  end

  add_foreign_key "bids", "carriers"
  add_foreign_key "bids", "load_types"
  add_foreign_key "bids", "shipping_routes"
end
