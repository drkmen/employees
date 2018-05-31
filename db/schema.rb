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

ActiveRecord::Schema.define(version: 2018_05_31_081606) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "employees", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "main_skill"
    t.string "description"
    t.string "email", null: false
    t.string "phone"
    t.string "office"
    t.integer "role", default: 0, null: false
    t.jsonb "additional", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["first_name", "last_name", "main_skill"], name: "index_employees_on_first_name_and_last_name_and_main_skill", unique: true
  end

  create_table "images", force: :cascade do |t|
    t.string "image"
    t.string "imageable_type"
    t.bigint "imageable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "description"
    t.string "client"
    t.bigint "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_projects_on_employee_id"
  end

  create_table "resource_skills", force: :cascade do |t|
    t.string "skillable_type"
    t.bigint "skillable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skillable_type", "skillable_id"], name: "index_resource_skills_on_skillable_type_and_skillable_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.integer "level"
    t.string "experience"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
