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

ActiveRecord::Schema.define(:version => 20090816123758) do

  create_table "categories", :force => true do |t|
    t.string   "search"
    t.integer  "latest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "location_aware", :default => false
    t.integer  "scan_count",     :default => 0
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

  create_table "games", :force => true do |t|
    t.string   "permalink"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "missions", :force => true do |t|
    t.string   "title"
    t.text     "summary"
    t.integer  "game_id"
    t.string   "permalink",  :limit => 60
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "missions", ["permalink"], :name => "index_missions_on_permalink"

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

  create_table "profiles", :force => true do |t|
    t.string   "screen_name"
    t.string   "location"
    t.string   "mapped_location"
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
  end

  create_table "sockpuppets", :force => true do |t|
    t.string   "screen_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", :force => true do |t|
    t.text     "text"
    t.string   "profile_image_url"
    t.string   "iso_language_code"
    t.integer  "from_user_id"
    t.string   "from_user"
    t.integer  "to_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "original"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "pseudo_id"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

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
