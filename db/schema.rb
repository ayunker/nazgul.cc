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

ActiveRecord::Schema[7.2].define(version: 2024_08_24_212002) do
  create_table "activities", force: :cascade do |t|
    t.bigint "strava_id", null: false
    t.string "external_id"
    t.string "name"
    t.decimal "distance", precision: 10, scale: 2
    t.decimal "moving_time", precision: 10, scale: 2
    t.decimal "elapsed_time", precision: 10, scale: 2
    t.date "activity_date"
    t.string "bike"
    t.decimal "average_speed", precision: 10, scale: 2
    t.decimal "max_speed", precision: 10, scale: 2
    t.decimal "average_watts", precision: 10, scale: 2
    t.boolean "with_kat", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
