# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_10_234531) do

  create_table "agent_skills", force: :cascade do |t|
    t.integer "modifier"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "agent_id", null: false
    t.integer "skill_id", null: false
    t.index ["agent_id"], name: "index_agent_skills_on_agent_id"
    t.index ["skill_id"], name: "index_agent_skills_on_skill_id"
  end

  create_table "agent_stats", force: :cascade do |t|
    t.integer "stat_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "stat_id", null: false
    t.integer "agent_id", null: false
    t.index ["agent_id"], name: "index_agent_stats_on_agent_id"
    t.index ["stat_id"], name: "index_agent_stats_on_stat_id"
  end

  create_table "agents", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "associations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "stat_id", null: false
    t.index ["stat_id"], name: "index_skills_on_stat_id"
  end

  create_table "stats", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "agent_skills", "agents"
  add_foreign_key "agent_skills", "skills"
  add_foreign_key "agent_stats", "agents"
  add_foreign_key "agent_stats", "stats"
  add_foreign_key "skills", "stats"
end
