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

ActiveRecord::Schema.define(:version => 20130530002613) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "confirmations", :force => true do |t|
    t.integer  "service_order_id"
    t.date     "performed_on"
    t.float    "travel_hours",     :default => 0.0
    t.float    "straight_hours",   :default => 0.0
    t.float    "overtime_hours",   :default => 0.0
    t.float    "doubletime_hours", :default => 0.0
    t.text     "description"
    t.string   "number"
    t.integer  "user_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "service_orders", :force => true do |t|
    t.string   "number"
    t.text     "description"
    t.integer  "category_id"
    t.integer  "user_id"
    t.float    "budget",      :default => 0.0
    t.boolean  "completed",   :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "shares", :force => true do |t|
    t.integer  "service_order_id"
    t.integer  "shared_with_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
