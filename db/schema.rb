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

ActiveRecord::Schema.define(version: 20140426195812) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "entries", force: true do |t|
    t.text     "content",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.uuid     "user_id"
    t.text     "content_html"
    t.inet     "ip_address"
  end

  add_index "entries", ["user_id"], name: "index_entries_on_user_id", using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "email",      null: false
    t.string   "username",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
