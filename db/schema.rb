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

ActiveRecord::Schema.define(version: 20140723051443) do

  create_table "cities", force: true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", force: true do |t|
    t.integer  "user_id"
    t.integer  "tour_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invitations", ["tour_id"], name: "index_invitations_on_tour_id"
  add_index "invitations", ["user_id"], name: "index_invitations_on_user_id"

  create_table "tour_stops", force: true do |t|
    t.integer  "tour_id"
    t.integer  "venue_id"
    t.integer  "status",     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tour_stops", ["tour_id"], name: "index_tour_stops_on_tour_id"
  add_index "tour_stops", ["venue_id"], name: "index_tour_stops_on_venue_id"

  create_table "tours", force: true do |t|
    t.string   "name",                     null: false
    t.integer  "organizer_id",             null: false
    t.integer  "city_id",                  null: false
    t.datetime "starting_at",              null: false
    t.string   "image"
    t.text     "description",  limit: 300
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",            limit: 28, null: false
    t.string   "email",           limit: 38, null: false
    t.string   "avatar_url"
    t.string   "password_digest",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "venues", force: true do |t|
    t.string   "name"
    t.integer  "city_id"
    t.integer  "cid"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
