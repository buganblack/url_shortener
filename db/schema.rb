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

ActiveRecord::Schema.define(version: 20170817095532) do

  create_table "shorten_urls", force: :cascade do |t|
    t.string   "original_url", limit: 255,             null: false
    t.string   "shorten_url",  limit: 255,             null: false
    t.integer  "total_visit",  limit: 4,   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shorten_urls", ["original_url"], name: "index_shorten_urls_on_original_url", using: :btree
  add_index "shorten_urls", ["shorten_url"], name: "index_shorten_urls_on_shorten_url", using: :btree

  create_table "url_statistics", force: :cascade do |t|
    t.string   "ip_address",     limit: 255,             null: false
    t.integer  "visit",          limit: 4,   default: 0
    t.integer  "shorten_url_id", limit: 4,               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "url_statistics", ["ip_address"], name: "index_url_statistics_on_ip_address", using: :btree
  add_index "url_statistics", ["shorten_url_id"], name: "index_url_statistics_on_shorten_url_id", using: :btree

end
