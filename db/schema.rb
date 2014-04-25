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

ActiveRecord::Schema.define(version: 20140425172308) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ad_other_fields", force: true do |t|
    t.integer  "ad_id"
    t.string   "tel"
    t.string   "source_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ad_other_fields", ["ad_id"], name: "index_ad_other_fields_on_ad_id", using: :btree
  add_index "ad_other_fields", ["source_url"], name: "index_ad_other_fields_on_source_url", using: :btree

  create_table "ads", force: true do |t|
    t.integer  "user_id"
    t.integer  "car_model_id"
    t.integer  "body_color_id"
    t.integer  "internal_color_id"
    t.integer  "scrap_id"
    t.string   "location"
    t.float    "latitude"
    t.float    "longitude"
    t.date     "year"
    t.integer  "price"
    t.integer  "millage"
    t.integer  "fuel"
    t.integer  "usage_type",        default: 10
    t.boolean  "girbox",            default: false
    t.boolean  "active",            default: false
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ads", ["car_model_id"], name: "index_ads_on_car_model_id", using: :btree
  add_index "ads", ["user_id"], name: "index_ads_on_user_id", using: :btree

  create_table "car_models", force: true do |t|
    t.string   "name"
    t.integer  "make_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "car_models", ["make_id"], name: "index_car_models_on_make_id", using: :btree
  add_index "car_models", ["name"], name: "index_car_models_on_name", using: :btree

  create_table "image_urls", force: true do |t|
    t.integer  "ad_id"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "image_urls", ["ad_id"], name: "index_image_urls_on_ad_id", using: :btree

  create_table "locations", force: true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["name"], name: "index_locations_on_name", using: :btree

  create_table "makes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "makes", ["name"], name: "index_makes_on_name", using: :btree

  create_table "scraps", force: true do |t|
    t.integer  "count"
    t.string   "url"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
