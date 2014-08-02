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

ActiveRecord::Schema.define(version: 20140801015138) do

  create_table "cities", force: true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "commenter_id",             null: false
    t.integer  "tour_stop_id",             null: false
    t.text     "text",         limit: 300, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commenter_id"], name: "index_comments_on_commenter_id"
  add_index "comments", ["tour_stop_id"], name: "index_comments_on_tour_stop_id"

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["friend_id"], name: "index_friendships_on_friend_id"
  add_index "friendships", ["user_id"], name: "index_friendships_on_user_id"

  create_table "invitations", force: true do |t|
    t.integer  "user_id"
    t.string   "tour_id",    limit: 64
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invitations", ["tour_id"], name: "index_invitations_on_tour_id"
  add_index "invitations", ["user_id"], name: "index_invitations_on_user_id"

  create_table "tour_stops", force: true do |t|
    t.string   "tour_id",    limit: 64
    t.integer  "venue_id"
    t.integer  "status",                default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tour_stops", ["tour_id"], name: "index_tour_stops_on_tour_id"
  add_index "tour_stops", ["venue_id"], name: "index_tour_stops_on_venue_id"

  create_table "tours", id: false, force: true do |t|
    t.string   "id",           limit: 64,               null: false
    t.string   "name",         limit: 128,              null: false
    t.integer  "organizer_id",                          null: false
    t.integer  "city_id",                               null: false
    t.datetime "starting_at",                           null: false
    t.string   "image"
    t.text     "description",  limit: 1000
    t.integer  "status",                    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tours", ["id"], name: "index_tours_on_id", unique: true

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

  create_table "votes", force: true do |t|
    t.integer  "voter_id",     null: false
    t.integer  "tour_stop_id", null: false
    t.integer  "score",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["tour_stop_id"], name: "index_votes_on_tour_stop_id"
  add_index "votes", ["voter_id"], name: "index_votes_on_voter_id"

end
