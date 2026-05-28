# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_05_28_143109) do
  create_table "league_members", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "league_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["league_id"], name: "index_league_members_on_league_id"
    t.index ["user_id"], name: "index_league_members_on_user_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "creator_id", null: false
    t.string "join_code"
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_leagues_on_creator_id"
    t.index ["join_code"], name: "index_leagues_on_join_code", unique: true
  end

  create_table "matches", force: :cascade do |t|
    t.integer "away_score"
    t.string "away_team", null: false
    t.datetime "created_at", null: false
    t.boolean "finished", default: false, null: false
    t.integer "home_score"
    t.string "home_team", null: false
    t.time "kickoff", null: false
    t.datetime "updated_at", null: false
  end

  create_table "predictions", force: :cascade do |t|
    t.integer "away_prediction"
    t.datetime "created_at", null: false
    t.integer "home_prediction"
    t.integer "match_id", null: false
    t.integer "points_earned"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["match_id"], name: "index_predictions_on_match_id"
    t.index ["user_id", "match_id"], name: "index_predictions_on_user_id_and_match_id", unique: true
    t.index ["user_id"], name: "index_predictions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "score", default: 0
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "league_members", "leagues"
  add_foreign_key "league_members", "users"
  add_foreign_key "leagues", "users", column: "creator_id"
  add_foreign_key "predictions", "matches"
  add_foreign_key "predictions", "users"
end
