class CreateDatabase < ActiveRecord::Migration
  create_table "chores", force: :cascade do |t|
    t.string   "name",           limit: 255,             null: false
    t.integer  "points",         limit: 4,   default: 0, null: false
    t.integer  "length_of_time", limit: 4
    t.integer  "times_per_week", limit: 4
    t.integer  "household_id",   limit: 4,               null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "chores", ["household_id"], name: "fk_HouseholdChore_Household1_idx", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name",        limit: 255,  null: false
    t.integer  "user_id",     limit: 4,    null: false
    t.string   "description", limit: 1000
    t.datetime "start",                    null: false
    t.datetime "end",                      null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "events", ["user_id"], name: "fk_Events_User1_idx", using: :btree

  create_table "households", force: :cascade do |t|
    t.string   "name",                 limit: 255, null: false
    t.integer  "head_of_household_id", limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "households", ["head_of_household_id"], name: "head_of_household_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",        limit: 45,              null: false
    t.string   "name",         limit: 255,             null: false
    t.integer  "points",       limit: 4,   default: 0, null: false
    t.integer  "household_id", limit: 4
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "users", ["email"], name: "email", using: :btree
  add_index "users", ["household_id"], name: "fk_User_Household1_idx", using: :btree

  create_table "users_chores", force: :cascade do |t|
    t.boolean  "completed",            default: false, null: false
    t.integer  "user_id",    limit: 4,                 null: false
    t.integer  "chore_id",   limit: 4,                 null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "users_chores", ["chore_id"], name: "chore_id", using: :btree
  add_index "users_chores", ["user_id"], name: "fk_UserChores_User1_idx", using: :btree

  add_foreign_key "chores", "households", name: "chores_ibfk_1"
  add_foreign_key "events", "users", name: "fk_events_users"
  # add_foreign_key "households", "users", column: "head_of_household_id", name: "households_ibfk_1"
  add_foreign_key "users", "households", name: "users_ibfk_1"
  add_foreign_key "users_chores", "chores", name: "users_chores_ibfk_2"
  add_foreign_key "users_chores", "users", name: "users_chores_ibfk_1"
end
