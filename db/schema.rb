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

ActiveRecord::Schema.define(version: 20190508161237) do

  create_table "active_admin_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "battings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "match_id"
    t.string "batsman"
    t.text "team_name"
    t.string "dismissal"
    t.float "strike_rate", limit: 24
    t.integer "sixes"
    t.integer "fours"
    t.integer "balls_played"
    t.integer "runs"
    t.string "dismissal_info"
    t.integer "pid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_battings_on_match_id"
  end

  create_table "bowlings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "team_name"
    t.string "bowler"
    t.integer "sixs"
    t.integer "fours"
    t.integer "zeros"
    t.integer "overs"
    t.integer "wickets"
    t.integer "runs"
    t.integer "maidens"
    t.float "econ", limit: 24
    t.integer "match_id"
    t.integer "pid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_bowlings_on_match_id"
  end

  create_table "fieldings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "fielder"
    t.integer "runout"
    t.integer "stumped"
    t.integer "bowled"
    t.integer "lbw"
    t.integer "catch"
    t.text "team_name"
    t.integer "match_id"
    t.integer "pid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_fieldings_on_match_id"
  end

  create_table "match_extras", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "match_id"
    t.text "team_name"
    t.text "details"
    t.integer "total_runs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_match_extras_on_match_id"
  end

  create_table "matches", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "unique_id"
    t.text "team_2"
    t.text "team_1"
    t.string "test_type"
    t.datetime "match_time"
    t.boolean "squad"
    t.text "toss_wt"
    t.text "winner_team"
    t.boolean "match_started"
    t.boolean "match_ended"
    t.boolean "publish"
    t.string "man_of_the_match"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "my_scores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.string "player_name"
    t.integer "batting_score"
    t.integer "bowling_score"
    t.integer "fielding_score"
    t.integer "total_score"
    t.integer "ranking"
    t.integer "match_id"
    t.integer "pid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_my_scores_on_match_id"
    t.index ["user_id"], name: "index_my_scores_on_user_id"
  end

  create_table "squads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "match_id"
    t.integer "user_id"
    t.string "player_ids"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_squads_on_match_id"
  end

  create_table "teams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "player"
    t.text "team_name"
    t.integer "pid"
    t.string "role"
    t.string "country"
    t.text "img_url"
    t.integer "points"
    t.integer "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_teams_on_match_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
