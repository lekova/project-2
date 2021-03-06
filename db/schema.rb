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

ActiveRecord::Schema.define(version: 20150807135642) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "title",                          null: false
    t.string   "author",                         null: false
    t.integer  "year"
    t.decimal  "price"
    t.text     "url"
    t.integer  "status",             default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "books", ["owner_id"], name: "index_books_on_owner_id", using: :btree

  create_table "conversations", force: :cascade do |t|
    t.integer  "user_one"
    t.integer  "user_two"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "loans", force: :cascade do |t|
    t.integer  "loaner_id",     null: false
    t.integer  "borrower_id",   null: false
    t.integer  "book_id",       null: false
    t.string   "date_loaned",   null: false
    t.integer  "loan_duration"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "loans", ["book_id"], name: "index_loans_on_book_id", using: :btree
  add_index "loans", ["borrower_id"], name: "index_loans_on_borrower_id", using: :btree
  add_index "loans", ["loaner_id"], name: "index_loans_on_loaner_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.text     "text"
    t.date     "date"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "token",           null: false
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["token"], name: "index_users_on_token", unique: true, using: :btree

  add_foreign_key "books", "users", column: "owner_id"
  add_foreign_key "loans", "books", on_delete: :cascade
  add_foreign_key "loans", "users", column: "borrower_id", on_delete: :cascade
  add_foreign_key "loans", "users", column: "loaner_id", on_delete: :cascade
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
end
