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

ActiveRecord::Schema.define(version: 20140416095706) do

  create_table "assets", force: true do |t|
    t.string   "description"
    t.string   "caption"
    t.integer  "user_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachments", force: true do |t|
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.string   "description"
    t.string   "image_size"
    t.integer  "position"
    t.integer  "asset_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "postno"
    t.string   "city"
    t.text     "log"
    t.string   "description"
    t.string   "phone"
    t.string   "email"
    t.integer  "partner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contents", force: true do |t|
    t.integer  "resource_id"
    t.string   "resource_type"
    t.integer  "parent_id"
    t.string   "navlabel"
    t.boolean  "active"
    t.boolean  "redirect"
    t.string   "controller_redirect"
    t.string   "action_redirect"
    t.integer  "position"
    t.string   "controller_name"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "body"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "headline"
    t.text     "body"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "partners", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "postno"
    t.string   "city"
    t.text     "log"
    t.string   "category"
    t.string   "responsible"
    t.text     "info"
    t.datetime "next_action"
    t.integer  "lock_version"
    t.integer  "user_id"
    t.integer  "search_lock"
    t.string   "phone"
    t.string   "email"
    t.string   "homepage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "priority"
    t.integer  "parent_id"
    t.integer  "user_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "preferences", force: true do |t|
    t.string   "name"
    t.string   "value"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.boolean  "active"
    t.string   "category"
    t.string   "blogname"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
