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

ActiveRecord::Schema.define(version: 2019_01_22_205259) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "days", force: :cascade do |t|
    t.date "fulldate"
    t.integer "month"
    t.integer "date"
    t.integer "year"
    t.integer "day"
    t.integer "week"
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
    t.string "pithomyces"
    t.string "powdery_mildew"
    t.string "puccinia"
    t.string "rust"
    t.string "spegazinia"
    t.string "stemphyllium"
    t.string "tetrapola"
    t.string "tilletia"
    t.string "torula"
    t.string "pestalotiopsis"
    t.string "pseudocercospora"
    t.string "polythrincium"
    t.string "pleospora"
    t.string "ash"
    t.string "walnut"
    t.string "birch"
    t.string "cotton_wood"
    t.string "dogwood"
    t.string "elm"
    t.string "glandular_mesquite"
    t.string "hackberry"
    t.string "hickory"
    t.string "mulberry"
    t.string "maple"
    t.string "osage_orange"
    t.string "oak"
    t.string "sycamore"
    t.string "pine"
    t.string "privet"
    t.string "sweet_gum"
    t.string "gingko_biloba"
    t.string "willow"
    t.string "amaranth"
    t.string "burweed___marshelder"
    t.string "cattail"
    t.string "dog_fennel"
    t.string "lambs_quarters"
    t.string "ragweed"
    t.string "rumex"
    t.string "sagebrush"
    t.string "saltbrush"
    t.string "sedge"
    t.string "ashe_juniper___bald_cypress"
    t.string "bushes"
    t.string "sneezeweed"
    t.string "black_gum"
    t.string "other_weed"
    t.string "other_tree"
    t.string "plantago"
    t.string "partridge_pea"
    t.string "pigweed"
    t.string "alder"
    t.string "cedar"
    t.string "hazelnut"
    t.string "plum_grannet"
    t.string "aster"
    t.string "nettle"
    t.string "magnolia"
    t.string "wild_carrot"
    t.string "black_walnut"
    t.string "walnutjuglans"
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
