# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091028180014) do

  create_table "contents", :force => true do |t|
    t.string   "title"
    t.string   "menutitle"
    t.string   "anchor"
    t.boolean  "publish"
    t.boolean  "hidden"
    t.integer  "order"
    t.text     "article"
    t.string   "contentpane"
    t.string   "contenttype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "panes", :force => true do |t|
    t.string   "title"
    t.string   "menutitle"
    t.string   "anchor"
    t.boolean  "publish"
    t.boolean  "hidden"
    t.boolean  "hasmenu"
    t.integer  "order"
    t.string   "panetype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shows", :force => true do |t|
    t.string   "name"
    t.string   "abbrev"
    t.string   "loc"
    t.string   "imageurl"
    t.string   "author"
    t.string   "ticketprices"
    t.string   "performancetimes"
    t.string   "ticketstatus"
    t.string   "homeshow"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "updates", :force => true do |t|
    t.string   "name"
    t.string   "anchor"
    t.datetime "expiredate"
    t.text     "article"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
