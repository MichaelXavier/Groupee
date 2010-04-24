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

ActiveRecord::Schema.define(:version => 20100502084029) do

  create_table "availabilities", :force => true do |t|
    t.integer  "day_of_week"
    t.time     "from"
    t.time     "to"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "availabilities_groups", :id => false, :force => true do |t|
    t.integer "availability_id"
    t.integer "group_id"
  end

  create_table "group_memberships", :force => true do |t|
    t.boolean  "leader",     :default => false
    t.string   "status"
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "user_limit", :default => 2
    t.string   "status",     :default => "active"
    t.string   "website"
    t.boolean  "open",       :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "studentid"
    t.string   "gender",     :default => "m"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
