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

ActiveRecord::Schema.define(version: 2019_01_15_174244) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "days", force: :cascade do |t|
    t.string "month"
    t.integer "date"
    t.integer "year"
    t.date "fulldate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "acrodictys"
    t.string "agrocybe"
    t.string "algae"
    t.string "alternaria"
    t.string "arthimium"
    t.string "ascomycetes"
    t.string "asperisporium"
    t.string "basidiomycetes"
    t.string "beltrania"
    t.string "botrytis"
    t.string "cercospora"
    t.string "cladosporium"
    t.string "curvularia"
    t.string "d_conidia_hyphae"
    t.string "dendryphiella"
    t.string "drechslera_helmintho"
    t.string "dichotomophthora"
    t.string "diplococcum"
    t.string "epicoccum"
    t.string "fusariella"
    t.string "ganoderma"
    t.string "helicomina"
    t.string "microsporum"
    t.string "misc_fungus_hyaline"
    t.string "monodictys"
    t.string "myxomycete_smut"
    t.string "nigrospora"
    t.string "penicillium_aspergillus"
    t.string "periconia"
    t.string "pestalotiopsis"
    t.string "pithomyces"
    t.string "powdery_mildew"
    t.string "pseudocercospora"
    t.string "puccinia"
    t.string "rust"
    t.string "spegazinia"
    t.string "stemphyllium"
    t.string "tetrapola"
    t.string "tilletia"
    t.string "torula"
  end

  create_table "feelings", force: :cascade do |t|
    t.integer "rating"
    t.bigint "day_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_id"], name: "index_feelings_on_day_id"
    t.index ["user_id"], name: "index_feelings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "feelings", "days"
  add_foreign_key "feelings", "users"
end
