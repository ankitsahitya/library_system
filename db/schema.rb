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

ActiveRecord::Schema.define(version: 20180323110549) do

  create_table "books", force: :cascade do |t|
    t.integer  "library_id",   limit: 4
    t.integer  "category_id",  limit: 4
    t.string   "name",         limit: 255
    t.decimal  "price",                    precision: 10
    t.string   "code",         limit: 255
    t.string   "author",       limit: 255
    t.string   "publication",  limit: 255
    t.string   "version",      limit: 255
    t.integer  "no_of_copies", limit: 4,                  default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "books", ["category_id"], name: "index_books_on_category_id", using: :btree
  add_index "books", ["library_id"], name: "index_books_on_library_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "issue_histories", force: :cascade do |t|
    t.integer  "member_id",    limit: 4
    t.integer  "book_id",      limit: 4
    t.date     "issue_date"
    t.date     "return_date"
    t.string   "type_of_book", limit: 255
    t.integer  "no_of_copies", limit: 4,   default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "issue_histories", ["book_id"], name: "fk_rails_00642e7022", using: :btree
  add_index "issue_histories", ["member_id"], name: "fk_rails_1e646b89f4", using: :btree

  create_table "libraries", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "address",    limit: 255
    t.integer  "phone_no",   limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: :cascade do |t|
    t.integer  "library_id",    limit: 4
    t.string   "name",          limit: 255
    t.string   "address",       limit: 255
    t.integer  "phone_no",      limit: 8
    t.string   "gender",        limit: 255
    t.integer  "code",          limit: 4
    t.date     "validity_date"
    t.boolean  "is_author",                 default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["library_id"], name: "fk_rails_c1b1972aa6", using: :btree

  create_table "users", force: :cascade do |t|
    t.string "name",          limit: 255
    t.string "email",         limit: 255
    t.string "provider_name", limit: 255
    t.string "provider_id",   limit: 255
  end

  add_foreign_key "books", "categories"
  add_foreign_key "books", "libraries"
  add_foreign_key "issue_histories", "books"
  add_foreign_key "issue_histories", "members"
  add_foreign_key "members", "libraries"
end
