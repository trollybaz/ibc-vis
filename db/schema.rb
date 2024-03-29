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

ActiveRecord::Schema.define(:version => 20120221014744) do

  create_table "attendances", :force => true do |t|
    t.integer "event_id",  :null => false
    t.integer "person_id", :null => false
  end

  create_table "event_type_members", :force => true do |t|
    t.integer "event_type_id", :null => false
    t.integer "person_id",     :null => false
  end

  create_table "event_types", :force => true do |t|
    t.string  "name",      :null => false
    t.integer "frequency"
  end

  create_table "events", :force => true do |t|
    t.integer "event_type_id", :null => false
    t.date    "date",          :null => false
  end

  create_table "families", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.string   "address"
  end

  create_table "people", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.date     "birthday"
    t.integer  "gender",      :limit => 2, :default => 0, :null => false
    t.integer  "family_id"
    t.string   "description"
    t.integer  "status",                   :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
