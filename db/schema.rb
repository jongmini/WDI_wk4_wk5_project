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

ActiveRecord::Schema.define(version: 20140204053937) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "journeys", force: true do |t|
    t.string   "name"
    t.string   "origin"
    t.decimal  "orig_lat"
    t.decimal  "orig_lng"
    t.string   "destination"
    t.decimal  "dest_lat"
    t.decimal  "dest_lng"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.decimal  "lat"
    t.decimal  "lng"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "search_str", limit: nil
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "waypoints", force: true do |t|
    t.decimal  "way_lat"
    t.decimal  "way_lng"
    t.integer  "journey_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
