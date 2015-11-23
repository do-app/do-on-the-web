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

ActiveRecord::Schema.define(version: 20151119043937) do

  create_table "chores", force: :cascade do |t|
    t.string   "name",           limit: 255, null: false
    t.integer  "points",         limit: 4,   null: false
    t.integer  "length_of_time", limit: 4,   null: false
    t.integer  "times_per_week", limit: 4,   null: false
    t.integer  "household_id",   limit: 4,   null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name",        limit: 255,   null: false
    t.integer  "user_id",     limit: 4,     null: false
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "households", force: :cascade do |t|
    t.string   "name",                 limit: 255, null: false
    t.integer  "head_of_household_id", limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body",         limit: 65535
    t.integer  "user_id",      limit: 4
    t.integer  "household_id", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255, null: false
    t.string   "email",           limit: 255, null: false
    t.integer  "points",          limit: 4,   null: false
    t.integer  "household_id",    limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "password_digest", limit: 255
  end

  create_table "users_chores", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,                 null: false
    t.integer  "chore_id",   limit: 4,                 null: false
    t.boolean  "completed",            default: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

end
