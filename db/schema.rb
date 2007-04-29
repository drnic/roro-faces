# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 12) do

  create_table "affiliations", :force => true do |t|
    t.column "user_id",   :integer
    t.column "group_id",  :integer
    t.column "visitor",   :boolean
    t.column "presenter", :boolean
    t.column "regular",   :boolean
  end

  create_table "facet_kinds", :force => true do |t|
    t.column "name",         :string,  :default => "", :null => false
    t.column "site",         :string
    t.column "feed",         :string
    t.column "aggregatable", :boolean
    t.column "title",        :string
    t.column "service_url",  :string
  end

  create_table "facets", :force => true do |t|
    t.column "name",          :string
    t.column "info",          :string,  :default => "", :null => false
    t.column "user_id",       :integer,                 :null => false
    t.column "facet_kind_id", :integer,                 :null => false
  end

  create_table "groups", :force => true do |t|
    t.column "name", :string
    t.column "url",  :string
  end

  create_table "mugshots", :force => true do |t|
    t.column "size",         :integer
    t.column "filename",     :string
    t.column "content_type", :string
    t.column "height",       :integer
    t.column "width",        :integer
    t.column "thumbnail",    :string
    t.column "parent_id",    :integer
  end

  create_table "sessions", :force => true do |t|
    t.column "session_id", :string
    t.column "data",       :text
    t.column "updated_at", :datetime
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.column "email",                     :string
    t.column "crypted_password",          :string,   :limit => 40
    t.column "salt",                      :string,   :limit => 40
    t.column "created_at",                :datetime
    t.column "updated_at",                :datetime
    t.column "remember_token",            :string
    t.column "remember_token_expires_at", :datetime
    t.column "mugshot_id",                :integer
    t.column "flickr_uid",                :string
    t.column "delicious_uid",             :string
    t.column "irc_nick",                  :string
    t.column "blurb",                     :string
    t.column "aliases",                   :string
    t.column "location",                  :string
    t.column "name",                      :string
    t.column "site_url",                  :string
    t.column "site_name",                 :string
    t.column "admin",                     :integer,  :limit => 4,  :default => 0, :null => false
    t.column "working_at",                :string
    t.column "working_on",                :string
    t.column "working_at_url",            :string
  end

end
