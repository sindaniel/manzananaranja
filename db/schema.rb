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

ActiveRecord::Schema.define(version: 20150714122021) do

  create_table "carbohydrates", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "phone"
    t.string   "password"
    t.integer  "sex"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menucarbohydrates", force: true do |t|
    t.integer  "menu_id"
    t.integer  "carbohydrate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menuclientes", force: true do |t|
    t.date     "date"
    t.integer  "protein_id"
    t.integer  "wok_id"
    t.integer  "salad_id"
    t.integer  "soup_id"
    t.integer  "carbohydrate_id"
    t.boolean  "estado"
    t.integer  "usuario_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menudia", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menuproteins", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "protein_id"
    t.integer  "menu_id"
  end

  add_index "menuproteins", ["menu_id"], name: "index_menuproteins_on_menu_id", using: :btree
  add_index "menuproteins", ["protein_id"], name: "index_menuproteins_on_protein_id", using: :btree

  create_table "menus", force: true do |t|
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "estado"
  end

  create_table "menusalads", force: true do |t|
    t.integer  "salad_id"
    t.integer  "menu_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menusoups", force: true do |t|
    t.integer  "menu_id"
    t.integer  "soup_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menuwoks", force: true do |t|
    t.integer  "menu_id"
    t.integer  "wok_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pictures", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "planclientes", force: true do |t|
    t.string   "name"
    t.integer  "service_id"
    t.integer  "customers_id"
    t.integer  "estado",       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proteins", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salads", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", force: true do |t|
    t.string   "name"
    t.integer  "dishes"
    t.integer  "discount"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "limite"
  end

  create_table "soups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "texts", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.boolean  "admin",                  default: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "woks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
