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

ActiveRecord::Schema.define(version: 20150719233652) do

  create_table "addresses", force: :cascade do |t|
    t.string   "address",          limit: 255
    t.string   "suburb",           limit: 255
    t.string   "city",             limit: 255
    t.string   "country_code",     limit: 2
    t.string   "postal_code",      limit: 10
    t.integer  "addressable_id",   limit: 4
    t.string   "addressable_type", limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "art_galleries", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.string   "slug",               limit: 255
    t.text     "body",               limit: 65535
    t.integer  "cover_photo_repeat", limit: 1,     default: 0
    t.text     "business_hours",     limit: 65535
    t.string   "state",              limit: 255
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "articles", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.text     "body",               limit: 65535
    t.string   "slug",               limit: 255
    t.integer  "cover_photo_repeat", limit: 1,     default: 0
    t.string   "state",              limit: 255
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "awards", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "year",           limit: 255
    t.string   "awardable_id",   limit: 255
    t.string   "awardable_type", limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "cafes", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.string   "slug",               limit: 255
    t.text     "body",               limit: 65535
    t.string   "menu",               limit: 255
    t.integer  "cover_photo_repeat", limit: 1,     default: 0
    t.string   "state",              limit: 255
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.text     "business_hours",     limit: 65535
    t.string   "food",               limit: 255
    t.string   "type",               limit: 255
    t.string   "drinks",             limit: 255
  end

  create_table "emerging_artists", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.string   "slug",               limit: 255
    t.text     "body",               limit: 65535
    t.integer  "cover_photo_repeat", limit: 1,     default: 0
    t.string   "state",              limit: 255
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.string   "slug",               limit: 255
    t.date     "starts_at"
    t.date     "ends_at"
    t.time     "opens_at"
    t.time     "closes_at"
    t.string   "admission",          limit: 255
    t.string   "email",              limit: 255
    t.text     "description",        limit: 65535
    t.string   "organizer",          limit: 255
    t.string   "pinterest",          limit: 255
    t.string   "instagram",          limit: 255
    t.string   "twitter",            limit: 255
    t.string   "facebook",           limit: 255
    t.integer  "cover_photo_repeat", limit: 1,     default: 0
    t.string   "state",              limit: 255
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "galleries", force: :cascade do |t|
    t.string "title", limit: 255
    t.string "state", limit: 255
    t.string "slug",  limit: 255
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.text     "body",               limit: 65535
    t.string   "meta_tags",          limit: 255
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "state",              limit: 255
    t.string   "slug",               limit: 255
    t.integer  "cover_photo_repeat", limit: 1,     default: 0
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "designation", limit: 255
    t.string   "bio_short",   limit: 255
    t.text     "bio",         limit: 65535
    t.string   "state",       limit: 255
    t.string   "slug",        limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id",        limit: 4
    t.integer "taggable_id",   limit: 4
    t.string  "taggable_type", limit: 255
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "slug",       limit: 255
    t.string   "type",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "role",                   limit: 4
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
