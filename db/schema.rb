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

ActiveRecord::Schema[8.0].define(version: 2025_04_21_145518) do
  create_table "searches", force: :cascade do |t|
    t.string "name"
    t.text "notes"
    t.text "keywords"
    t.boolean "include_description"
    t.string "category"
    t.string "condition"
    t.string "postal_code"
    t.string "type"
    t.integer "price_min_cents"
    t.integer "price_max_cents"
    t.integer "best_offer_max_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
