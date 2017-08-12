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

ActiveRecord::Schema.define(version: 20170205113553) do

  create_table "lectures", force: :cascade do |t|
    t.string "name", null: false
    t.string "content", null: false
    t.date "date", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.datetime "deadline", null: false
    t.integer "max_points", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name", null: false
    t.integer "faculty_number", null: false
    t.string "e_mail", null: false
    t.string "password_digest", null: false
    t.boolean "admin", default: false, null: false
    t.string "photo"
    t.string "about"
    t.string "github"
    t.index ["e_mail"], name: "index_users_on_e_mail", unique: true
    t.index ["faculty_number"], name: "index_users_on_faculty_number", unique: true
  end

end
