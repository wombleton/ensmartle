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

ActiveRecord::Schema.define(:version => 20090528230017) do

  create_table "categories", :force => true do |t|
    t.string   "search"
    t.integer  "latest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "location_aware", :default => false
    t.integer  "scan_count",     :default => 0
  end

  create_table "characters", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pseudo_id"
    t.integer  "realm_id"
    t.string   "guild"
    t.string   "armoury_url"
  end

  create_table "components", :force => true do |t|
    t.integer "item_id"
    t.integer "reagent_id"
  end

  create_table "games", :force => true do |t|
    t.string   "permalink"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.string   "icon_base"
    t.integer  "level"
    t.string   "quality"
    t.string   "profession_name"
    t.boolean  "populated",       :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "armory_id"
  end

  create_table "missions", :force => true do |t|
    t.string   "title"
    t.text     "summary"
    t.integer  "game_id"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "professions", :force => true do |t|
    t.integer  "character_id"
    t.integer  "max"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "pseudo_id"
  end

  create_table "profiles", :force => true do |t|
    t.string   "screen_name"
    t.string   "location"
    t.string   "mapped_location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "realms", :force => true do |t|
    t.string   "name"
    t.string   "pseudo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "spell_id",      :null => false
    t.integer  "profession_id", :null => false
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

  create_table "sockpuppets", :force => true do |t|
    t.string   "screen_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spells", :force => true do |t|
    t.string   "name"
    t.string   "icon_base"
    t.integer  "spell_id"
    t.string   "tradeskill"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "tooltip"
    t.string   "category"
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

end
