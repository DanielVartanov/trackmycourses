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

ActiveRecord::Schema.define(:version => 20121014200313) do

  create_table "accounts", :force => true do |t|
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.boolean  "twitter_notify", :default => false
  end

  create_table "authentications", :force => true do |t|
    t.integer  "account_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "nickname"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "chapters", :force => true do |t|
    t.integer  "course_id"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "number"
  end

  create_table "courses", :force => true do |t|
    t.integer  "platform_id"
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.string   "logo_url"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.date     "start_date"
  end

  create_table "platforms", :force => true do |t|
    t.string   "url"
    t.string   "name"
    t.string   "logo_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sections", :force => true do |t|
    t.integer  "chapter_id"
    t.string   "title"
    t.integer  "practice_count"
    t.datetime "due_date"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "url"
    t.integer  "score_count"
    t.integer  "duration"
    t.string   "type"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "course_id"
    t.integer  "account_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
