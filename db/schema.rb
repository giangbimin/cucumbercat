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

ActiveRecord::Schema.define(version: 20170623035546) do

  create_table "chanels", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.string "avatar_url"
    t.string "chanel_type", default: "self"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer "user_id"
    t.integer "chanel_id"
    t.text "body"
    t.boolean "read_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chanel_id"], name: "index_messages_on_chanel_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "user_chanels", force: :cascade do |t|
    t.integer "user_id"
    t.integer "chanel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chanel_id"], name: "index_user_chanels_on_chanel_id"
    t.index ["user_id"], name: "index_user_chanels_on_user_id"
  end

  create_table "user_relationships", force: :cascade do |t|
    t.integer "user_id"
    t.string "friend_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_relationships_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "full_name"
    t.string "gender"
    t.string "avatar_url"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
