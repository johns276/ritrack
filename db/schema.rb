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

ActiveRecord::Schema.define(version: 20130827150753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: true do |t|
    t.string   "company"
    t.string   "organization"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["user_id"], name: "index_locations_on_user_id", using: :btree

  create_table "phones", force: true do |t|
    t.string   "number"
    t.string   "tag"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phones", ["number"], name: "index_phones_on_number", using: :btree
  add_index "phones", ["user_id"], name: "index_phones_on_user_id", using: :btree

  create_table "ticket_queues", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "url"
    t.integer  "priority"
    t.integer  "default_due_in"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_responses", force: true do |t|
    t.text     "body"
    t.datetime "response_sent"
    t.integer  "ticket_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ticket_responses", ["ticket_id"], name: "index_ticket_responses_on_ticket_id", using: :btree

  create_table "tickets", force: true do |t|
    t.string   "subject"
    t.string   "status"
    t.integer  "priority"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "due_date"
    t.integer  "user_id"
    t.integer  "ticket_queue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "requestor_id"
  end

  add_index "tickets", ["requestor_id"], name: "index_tickets_on_requestor_id", using: :btree
  add_index "tickets", ["ticket_queue_id"], name: "index_tickets_on_ticket_queue_id", using: :btree
  add_index "tickets", ["user_id"], name: "index_tickets_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nick_name"
    t.string   "login_name"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "is_admin"
    t.boolean  "can_login"
    t.boolean  "user_by_email"
  end

end
