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

ActiveRecord::Schema.define(version: 2021_03_17_160330) do

  create_table "works", force: :cascade do |t|
    t.integer "writer_id", null: false
    t.string "name", null: false
    t.string "pronunciation", null: false
    t.string "file_url", null: false
    t.string "wikipedia_url", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["writer_id"], name: "index_works_on_writer_id"
  end

  create_table "writers", force: :cascade do |t|
    t.string "name", null: false
    t.string "pronunciation", null: false
    t.string "romaji", null: false
    t.date "born_at", null: false
    t.date "dead_at"
    t.string "summary", null: false
    t.string "wikipedia_url", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
