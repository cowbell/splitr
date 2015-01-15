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

ActiveRecord::Schema.define(version: 20150115163751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "budgets", force: true do |t|
    t.string   "name",            limit: nil
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "currency",        limit: nil, default: ""
    t.integer  "precision"
    t.string   "separator",       limit: nil
    t.string   "delimiter",       limit: nil
    t.string   "format",          limit: nil
    t.string   "negative_format", limit: nil
  end

  create_table "members", force: true do |t|
    t.integer  "user_id"
    t.integer  "budget_id",              null: false
    t.string   "name",       limit: nil, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["budget_id"], name: "index_members_on_budget_id", using: :btree
  add_index "members", ["name", "budget_id"], name: "index_members_on_name_and_budget_id", unique: true, using: :btree
  add_index "members", ["user_id", "budget_id"], name: "index_members_on_user_id_and_budget_id", unique: true, using: :btree
  add_index "members", ["user_id"], name: "index_members_on_user_id", using: :btree

  create_table "money_transactions", force: true do |t|
    t.text     "description",                          null: false
    t.integer  "budget_id",                            null: false
    t.decimal  "amount",      precision: 16, scale: 8, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "issued_on",                            null: false
    t.integer  "payer_id"
  end

  add_index "money_transactions", ["budget_id"], name: "index_money_transactions_on_budget_id", using: :btree

  create_table "participations", force: true do |t|
    t.integer  "money_transaction_id"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participations", ["member_id"], name: "index_participations_on_member_id", using: :btree
  add_index "participations", ["money_transaction_id", "member_id"], name: "index_participations_on_money_transaction_id_and_member_id", unique: true, using: :btree
  add_index "participations", ["money_transaction_id"], name: "index_participations_on_money_transaction_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name",            limit: nil
    t.string   "email",           limit: nil
    t.string   "password_digest", limit: nil
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
