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

ActiveRecord::Schema.define(:version => 20101010101728) do

  create_table "contents", :force => true do |t|
    t.string   "title"
    t.string   "anchor"
    t.boolean  "publish"
    t.integer  "order"
    t.text     "article"
    t.string   "contentpane"
    t.string   "contenttype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rezlineitems", :force => true do |t|
    t.integer  "ticketrez_id"
    t.string   "performance"
    t.integer  "ticketsection_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roleassocs", :force => true do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "rname"
    t.string "rabbrev"
    t.string "rcontents"
    t.string "rrezlineitems"
    t.string "rroleassocs"
    t.string "rroles"
    t.string "rshows"
    t.string "rticketalerts"
    t.string "rticketrezs"
    t.string "rticketsections"
    t.string "rupdates"
    t.string "rusers"
    t.string "rboxoffice"
  end

  create_table "shows", :force => true do |t|
    t.string   "name"
    t.string   "abbrev"
    t.string   "loc"
    t.string   "imageurl"
    t.string   "author"
    t.string   "performancetimes"
    t.string   "ticketstatus"
    t.string   "director"
    t.boolean  "timesvisible"
    t.string   "shortdisplayname"
    t.string   "housemanname"
    t.string   "housemanemail"
    t.text     "ticketnotes"
    t.string   "seatingmap"
    t.string   "slot"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticketalerts", :force => true do |t|
    t.integer  "show_id"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticketrezs", :force => true do |t|
    t.integer  "show_id"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.boolean  "hasid"
    t.string   "salt"
    t.string   "hashid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticketsections", :force => true do |t|
    t.integer  "show_id"
    t.string   "name"
    t.integer  "size"
    t.integer  "pricewithid"
    t.integer  "pricewoutid"
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
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
