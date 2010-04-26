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

ActiveRecord::Schema.define(:version => 20100426115642) do

  create_table "blocks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "twit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", :force => true do |t|
    t.datetime "date"
    t.string   "document_type"
    t.string   "title"
    t.string   "pdf_name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "data",       :limit => 512
    t.integer  "mission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "event_type", :limit => 15
    t.boolean  "exploded"
    t.integer  "sheet_id"
    t.string   "result"
    t.integer  "user_id"
  end

  add_index "events", ["created_at"], :name => "index_events_on_created_at"
  add_index "events", ["mission_id"], :name => "index_events_on_mission_id"

  create_table "missions", :force => true do |t|
    t.string   "title"
    t.text     "summary"
    t.integer  "game_id"
    t.string   "permalink",  :limit => 60
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "missions", ["permalink"], :name => "index_missions_on_permalink"

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :null => false
    t.string  "server_url"
    t.string  "salt",       :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "image_path"
    t.integer  "page_no"
    t.integer  "document_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "keywords"
    t.text     "page_html"
  end

  create_table "persisted_files", :force => true do |t|
    t.datetime "question_date"
    t.string   "parliament_name"
    t.string   "parliament_url"
    t.string   "status"
    t.boolean  "persisted"
    t.boolean  "downloaded"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rolls", :force => true do |t|
    t.string   "by"
    t.integer  "number"
    t.string   "value"
    t.boolean  "exploded"
    t.integer  "mission_id"
    t.string   "ip_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rolls", ["mission_id"], :name => "index_rolls_on_mission_id"

  create_table "sections", :force => true do |t|
    t.integer  "page_id"
    t.text     "content"
    t.integer  "x"
    t.integer  "y"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sheets", :force => true do |t|
    t.string   "name"
    t.integer  "age"
    t.string   "home"
    t.string   "colour"
    t.string   "rank"
    t.string   "cloak"
    t.string   "parents"
    t.string   "artisan"
    t.string   "mentor"
    t.string   "friend"
    t.string   "enemy"
    t.integer  "fate"
    t.integer  "persona"
    t.boolean  "hungry"
    t.boolean  "angry"
    t.boolean  "tired"
    t.boolean  "injured"
    t.boolean  "sick"
    t.string   "belief",     :limit => 1024
    t.string   "goal",       :limit => 1024
    t.string   "instinct",   :limit => 1024
    t.string   "gear",       :limit => 1024
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "player",                     :default => true, :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.integer  "login_count",                       :default => 0, :null => false
    t.integer  "failed_login_count",                :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "openid_identifier"
    t.string   "atoken"
    t.string   "asecret"
    t.string   "screen_name",         :limit => 30
    t.string   "stance"
    t.string   "name"
    t.string   "url"
    t.string   "profile_image_url"
    t.boolean  "bad_url"
    t.string   "tweetblocker_rating", :limit => 5
    t.boolean  "forgiven"
    t.integer  "last_tweet_id"
    t.string   "last_tweet"
  end

  add_index "users", ["openid_identifier"], :name => "index_users_on_openid_identifier"

  create_table "written_questions", :force => true do |t|
    t.text     "question"
    t.text     "answer"
    t.string   "status"
    t.integer  "question_number"
    t.integer  "question_year"
    t.string   "asker_url"
    t.string   "asker_name"
    t.string   "portfolio_url"
    t.string   "portfolio_name"
    t.string   "respondent_url"
    t.string   "respondent_name"
    t.date     "date_asked"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "written_questions", ["question_year", "question_number"], :name => "index_written_questions_on_question_year_and_question_number"
  add_index "written_questions", ["updated_at"], :name => "index_written_questions_on_updated_at"

end
