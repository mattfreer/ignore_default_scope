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

ActiveRecord::Schema.define(:version => 20121222213327) do

  create_table "comments", :force => true do |t|
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "comments", ["author_type", "author_id"], :name => "index_comments_on_author_type_and_author_id"

  create_table "customers", :force => true do |t|
    t.string   "customer_no"
    t.string   "email"
    t.string   "fullname"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.datetime "deleted_at"
  end

  create_table "projects", :force => true do |t|
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "name",       :limit => 50, :null => false
    t.integer  "creator_id"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.datetime "deleted_at"
    t.string   "user_name",  :limit => 50
  end

  add_index "users", ["deleted_at"], :name => "index_users_on_deleted_at"

end
