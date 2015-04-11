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

ActiveRecord::Schema.define(version: 20150404073531) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auths", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "login_type"
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chats", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "vote_id",    null: false
    t.text     "chat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "chats", ["user_id"], name: "index_chats_on_user_id", using: :btree
  add_index "chats", ["vote_id"], name: "index_chats_on_vote_id", using: :btree

  create_table "choices", force: :cascade do |t|
    t.integer  "vote_id"
    t.integer  "restaurant_id"
    t.integer  "count",         default: 0
    t.boolean  "count_lock",    default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "choices", ["restaurant_id"], name: "index_choices_on_restaurant_id", using: :btree
  add_index "choices", ["vote_id"], name: "index_choices_on_vote_id", using: :btree

  create_table "crews", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "crews", ["group_id"], name: "index_crews_on_group_id", using: :btree
  add_index "crews", ["user_id"], name: "index_crews_on_user_id", using: :btree

  create_table "devices", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "os_type",    null: false
    t.string   "push_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "pickup",     default: 0
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id",       null: false
    t.integer  "restaurant_id", null: false
    t.integer  "rating"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "ratings", ["restaurant_id"], name: "index_ratings_on_restaurant_id", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "restaurants", force: :cascade do |t|
    t.string   "place_id",   null: false
    t.float    "lat"
    t.float    "lng"
    t.string   "name"
    t.string   "picture"
    t.float    "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "restaurants", ["place_id"], name: "index_restaurants_on_place_id", using: :btree

  create_table "rsvps", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "vote_id",    null: false
    t.integer  "rsvp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "rsvps", ["user_id"], name: "index_rsvps_on_user_id", using: :btree
  add_index "rsvps", ["vote_id"], name: "index_rsvps_on_vote_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "friends_from_id"
    t.integer  "friends_to_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "fb_id"
    t.string   "name"
    t.string   "picture"
    t.string   "contact"
    t.string   "role",       default: "user"
    t.string   "email"
    t.string   "password"
    t.boolean  "registered", default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "users", ["fb_id"], name: "index_users_on_fb_id", using: :btree

  create_table "verifications", force: :cascade do |t|
    t.string   "code",       null: false
    t.string   "contact",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "group_id"
    t.string   "vote_type"
    t.string   "name"
    t.integer  "expires_in"
    t.integer  "restaurant_id"
    t.datetime "expires_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "votes", ["group_id"], name: "index_votes_on_group_id", using: :btree

end
