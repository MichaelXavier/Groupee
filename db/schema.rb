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

ActiveRecord::Schema.define(:version => 20100531032724) do

  create_table "agenda_items", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "meeting_id"
    t.boolean  "completed",   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignments", :force => true do |t|
    t.string   "name"
    t.integer  "course_id"
    t.datetime "assigned"
    t.datetime "due"
    t.integer  "user_limit", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "courses", :force => true do |t|
    t.string   "title"
    t.string   "sln"
    t.string   "catalog_name"
    t.string   "section"
    t.string   "quarter"
    t.integer  "year"
    t.integer  "instructor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses_users", :id => false, :force => true do |t|
    t.integer "course_id"
    t.integer "user_id"
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
    t.integer  "course_id"
  end

  create_table "link_types", :force => true do |t|
    t.string   "name"
    t.decimal  "weight",     :precision => 3, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "links", :force => true do |t|
    t.integer  "link_type_id"
    t.integer  "left_user_id"
    t.integer  "right_user_id"
    t.integer  "context_id"
    t.string   "context_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meetings", :force => true do |t|
    t.string   "title"
    t.datetime "from_date"
    t.datetime "to_date"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meetings_users", :id => false, :force => true do |t|
    t.integer "meeting_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "studentid"
    t.string   "gender",                              :default => "m"
    t.string   "type"
    t.string   "email",                               :default => "",  :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",  :null => false
    t.string   "password_salt",                       :default => "",  :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
