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

ActiveRecord::Schema.define(version: 20140424184938) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ads", force: true do |t|
    t.integer  "user_id"
    t.integer  "carmodel_id"
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
    t.string   "origin_url"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ads", ["body_color_id"], name: "index_ads_on_body_color_id", using: :btree
  add_index "ads", ["carmodel_id"], name: "index_ads_on_carmodel_id", using: :btree
  add_index "ads", ["internal_color_id"], name: "index_ads_on_internal_color_id", using: :btree
  add_index "ads", ["scrap_id"], name: "index_ads_on_scrap_id", using: :btree
  add_index "ads", ["user_id"], name: "index_ads_on_user_id", using: :btree

  create_table "scraps", force: true do |t|
    t.integer  "count"
    t.string   "url"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
