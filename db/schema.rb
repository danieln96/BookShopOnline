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

ActiveRecord::Schema.define(version: 2018_03_06_081606) do

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "homenumber"
    t.string "apartnumber"
    t.string "postalcode"
    t.string "city"
    t.string "telnumber"
    t.integer "user_id"
    t.string "first_name"
    t.string "last_name"
  end

  create_table "book_categories", force: :cascade do |t|
    t.integer "book_id"
    t.integer "category_id"
  end

  create_table "book_opinions", force: :cascade do |t|
    t.integer "book_id"
    t.integer "user_id"
    t.integer "opinion_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.string "publisher"
    t.string "pdate"
    t.string "isbn"
    t.string "pages"
    t.integer "copies"
    t.decimal "price", precision: 5, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "counter", default: 0
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "deliveries", force: :cascade do |t|
    t.string "title"
    t.decimal "price"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "opinions", force: :cascade do |t|
    t.text "description"
    t.integer "rate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "book_id"
    t.integer "user_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "book_id"
    t.integer "quantity"
    t.integer "order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "total"
    t.string "status"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "delivery_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.boolean "admin", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
