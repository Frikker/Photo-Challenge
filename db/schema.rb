# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_06_111913) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "photopost_id", null: false
    t.bigint "parent_id"
    t.text "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_id"], name: "index_comments_on_parent_id"
    t.index ["photopost_id"], name: "index_comments_on_photopost_id"
    t.index ["user_id", "parent_id", "photopost_id"], name: "index_comments_on_user_id_and_parent_id_and_photopost_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "photoposts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "picture"
    t.integer "rating_count", default: 0
    t.integer "comments_count", default: 0
    t.string "aasm_state"
    t.string "ban_reason"
    t.index ["user_id", "created_at"], name: "index_photoposts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_photoposts_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "photopost_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["photopost_id", "user_id"], name: "index_ratings_on_photopost_id_and_user_id"
    t.index ["photopost_id"], name: "index_ratings_on_photopost_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "token"
    t.string "provider"
    t.string "uid"
    t.string "nickname"
    t.string "urls"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "authenticity_token"
    t.index ["authenticity_token"], name: "index_users_on_authenticity_token", unique: true
    t.index ["token"], name: "index_users_on_token"
    t.index ["uid"], name: "index_users_on_uid"
  end

  add_foreign_key "comments", "photoposts"
  add_foreign_key "comments", "users"
  add_foreign_key "photoposts", "users"
end
