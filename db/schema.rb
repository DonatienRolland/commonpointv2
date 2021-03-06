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

ActiveRecord::Schema.define(version: 2018_12_31_063456) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "title"
    t.string "icon"
    t.integer "total_user", default: 0
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_activities_on_category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "nom"
    t.string "adresse"
    t.string "description"
    t.float "latitude"
    t.float "longitude"
    t.string "icon"
    t.string "email_domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "licence"
  end

  create_table "evenements", force: :cascade do |t|
    t.decimal "prix"
    t.integer "nombre_min"
    t.integer "nombre_max"
    t.string "adresse"
    t.integer "type_of_evenement"
    t.date "jour"
    t.time "heur"
    t.float "latitude"
    t.float "longitude"
    t.bigint "user_id"
    t.bigint "user_activity_id"
    t.boolean "full", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "point_group_id"
    t.boolean "boosted", default: false, null: false
    t.index ["point_group_id"], name: "index_evenements_on_point_group_id"
    t.index ["user_activity_id"], name: "index_evenements_on_user_activity_id"
    t.index ["user_id"], name: "index_evenements_on_user_id"
  end

  create_table "materiels", force: :cascade do |t|
    t.string "title"
    t.text "note"
    t.bigint "participant_id"
    t.bigint "evenement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evenement_id"], name: "index_materiels_on_evenement_id"
    t.index ["participant_id"], name: "index_materiels_on_participant_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.bigint "evenement_id"
    t.bigint "participant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evenement_id"], name: "index_messages_on_evenement_id"
    t.index ["participant_id"], name: "index_messages_on_participant_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.boolean "invitation_prive", default: true
    t.boolean "invitation_publique", default: true
    t.boolean "message", default: true
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "participants", force: :cascade do |t|
    t.boolean "participe"
    t.bigint "user_id"
    t.bigint "evenement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evenement_id"], name: "index_participants_on_evenement_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "point_groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_activities", force: :cascade do |t|
    t.string "information"
    t.integer "level"
    t.bigint "user_id"
    t.bigint "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_user_activities_on_activity_id"
    t.index ["user_id"], name: "index_user_activities_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "prenom"
    t.string "nom"
    t.string "avatar"
    t.string "telephone"
    t.boolean "admin", default: false, null: false
    t.boolean "rh", default: false, null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "visits", force: :cascade do |t|
    t.integer "user_id"
    t.string "user_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id"
  end

  add_foreign_key "activities", "categories"
  add_foreign_key "evenements", "point_groups"
  add_foreign_key "evenements", "user_activities"
  add_foreign_key "evenements", "users"
  add_foreign_key "materiels", "evenements"
  add_foreign_key "materiels", "participants"
  add_foreign_key "messages", "evenements"
  add_foreign_key "messages", "participants"
  add_foreign_key "notifications", "users"
  add_foreign_key "participants", "evenements"
  add_foreign_key "participants", "users"
  add_foreign_key "user_activities", "activities"
  add_foreign_key "user_activities", "users"
  add_foreign_key "users", "companies"
end
