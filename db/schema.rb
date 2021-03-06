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

ActiveRecord::Schema.define(version: 20161217202931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "subsite_id"
    t.string   "url"
    t.string   "author"
    t.string   "text"
    t.datetime "written_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "site_comment_ident"
    t.string   "site_thread_ident"
    t.string   "html"
    t.string   "thread_title"
  end

  create_table "mentions", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_groups", force: :cascade do |t|
    t.string   "amazon_name"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "asin"
    t.string   "title"
    t.integer  "product_group_id"
    t.string   "url"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "image_url"
  end

  create_table "scrape_logs", force: :cascade do |t|
    t.string   "job_type"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "start_ident"
    t.string   "end_ident"
    t.integer  "mentions_count"
    t.integer  "comments_count"
    t.boolean  "error"
    t.string   "error_message"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "pages_count"
  end

  create_table "sites", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subsites", force: :cascade do |t|
    t.integer  "site_id"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
