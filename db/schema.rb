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

ActiveRecord::Schema.define(version: 2019_02_21_144311) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "data_formats", force: :cascade do |t|
    t.string "key_id"
    t.text "input_data"
    t.text "data_constraints"
    t.boolean "validation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "init_creates", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "creator_name"
    t.string "creator_email"
    t.string "contributor_name"
    t.string "contributor_email"
    t.text "usage_policy"
    t.text "data_model"
    t.text "data_constraints"
    t.text "data_example"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "key_id"
    t.text "init_trig"
    t.text "image_constraints"
    t.boolean "validation"
    t.string "validation_url"
    t.string "data_format"
    t.string "creator_type"
  end

  create_table "usage_creates", force: :cascade do |t|
    t.string "key_id"
    t.string "recipient"
    t.string "purpose"
    t.string "processing"
    t.string "storage_location"
    t.string "storage_duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "usage_policy"
    t.text "data_category"
  end

  create_table "usage_matches", force: :cascade do |t|
    t.string "key_id"
    t.text "data_subject"
    t.text "data_controller"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "match_valid"
  end

end
