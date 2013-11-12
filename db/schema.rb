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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131112154802) do

  create_table "authorships", :force => true do |t|
    t.integer  "package_id"
    t.integer  "contributor_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "authorships", ["package_id", "contributor_id"], :name => "index_authorships_on_package_id_and_contributor_id", :unique => true

  create_table "contributors", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "maintenances", :force => true do |t|
    t.integer  "package_id"
    t.integer  "contributor_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "maintenances", ["package_id", "contributor_id"], :name => "index_maintenances_on_package_id_and_contributor_id", :unique => true

  create_table "packages", :force => true do |t|
    t.string   "name"
    t.string   "version"
    t.string   "r_version"
    t.string   "dependencies"
    t.text     "suggestions"
    t.datetime "published_at"
    t.string   "title"
    t.text     "description"
    t.string   "license"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "packages", ["name", "version"], :name => "index_packages_on_name_and_version", :unique => true

end
