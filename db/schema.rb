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

ActiveRecord::Schema.define(version: 20140829173747) do

  create_table "comments", force: :cascade do |t|
    t.datetime "created_at",                                                                    null: false
    t.datetime "updated_at"
    t.string   "short_id",           limit: 10,                                 default: "",    null: false
    t.integer  "story_id",           limit: 4,                                                  null: false
    t.integer  "user_id",            limit: 4,                                                  null: false
    t.integer  "parent_comment_id",  limit: 4
    t.integer  "thread_id",          limit: 4
    t.text     "comment",            limit: 16777215,                                           null: false
    t.integer  "upvotes",            limit: 4,                                  default: 0,     null: false
    t.integer  "downvotes",          limit: 4,                                  default: 0,     null: false
    t.decimal  "confidence",                          precision: 20, scale: 19, default: 0.0,   null: false
    t.text     "markeddown_comment", limit: 16777215
    t.boolean  "is_deleted",         limit: 1,                                  default: false
    t.boolean  "is_moderated",       limit: 1,                                  default: false
    t.boolean  "is_from_email",      limit: 1,                                  default: false
  end

  add_index "comments", ["confidence"], name: "confidence_idx", using: :btree
  add_index "comments", ["short_id"], name: "short_id", unique: true, using: :btree
  add_index "comments", ["story_id", "short_id"], name: "story_id_short_id", using: :btree
  add_index "comments", ["thread_id"], name: "thread_id", using: :btree

  create_table "invitation_requests", force: :cascade do |t|
    t.string   "code",        limit: 255
    t.boolean  "is_verified", limit: 1,     default: false
    t.string   "email",       limit: 255
    t.string   "name",        limit: 255
    t.text     "memo",        limit: 65535
    t.string   "ip_address",  limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "invitations", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "email",      limit: 255
    t.string   "code",       limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.text     "memo",       limit: 16777215
  end

  create_table "keystores", id: false, force: :cascade do |t|
    t.string  "key",   limit: 50, default: "", null: false
    t.integer "value", limit: 8
  end

  add_index "keystores", ["key"], name: "key", unique: true, using: :btree

  create_table "messages", force: :cascade do |t|
    t.datetime "created_at"
    t.integer  "author_user_id",       limit: 4
    t.integer  "recipient_user_id",    limit: 4
    t.boolean  "has_been_read",        limit: 1,        default: false
    t.string   "subject",              limit: 100
    t.text     "body",                 limit: 16777215
    t.string   "short_id",             limit: 30
    t.boolean  "deleted_by_author",    limit: 1,        default: false
    t.boolean  "deleted_by_recipient", limit: 1,        default: false
  end

  add_index "messages", ["short_id"], name: "random_hash", unique: true, using: :btree

  create_table "moderations", force: :cascade do |t|
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "moderator_user_id", limit: 4
    t.integer  "story_id",          limit: 4
    t.integer  "comment_id",        limit: 4
    t.integer  "user_id",           limit: 4
    t.text     "action",            limit: 16777215
    t.text     "reason",            limit: 16777215
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,   null: false
    t.string   "comment_id", limit: 255, null: false
    t.boolean  "unread",     limit: 1,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["user_id", "comment_id"], name: "unique_notification_id", using: :btree

  create_table "reply_markers", force: :cascade do |t|
    t.integer  "user_id",    limit: 4, null: false
    t.datetime "date",                 null: false
    t.boolean  "unread",     limit: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reply_markers", ["user_id", "date"], name: "unique_reply_marker_id", using: :btree

  create_table "stories", force: :cascade do |t|
    t.datetime "created_at"
    t.integer  "user_id",                limit: 4
    t.string   "url",                    limit: 250,                                default: ""
    t.string   "title",                  limit: 150,                                default: "",  null: false
    t.text     "description",            limit: 16777215
    t.string   "short_id",               limit: 6,                                  default: "",  null: false
    t.integer  "is_expired",             limit: 1,                                  default: 0,   null: false
    t.integer  "upvotes",                limit: 4,                                  default: 0,   null: false
    t.integer  "downvotes",              limit: 4,                                  default: 0,   null: false
    t.integer  "is_moderated",           limit: 1,                                  default: 0,   null: false
    t.decimal  "hotness",                                 precision: 20, scale: 10, default: 0.0, null: false
    t.text     "markeddown_description", limit: 16777215
    t.text     "story_cache",            limit: 16777215
    t.integer  "comments_count",         limit: 4,                                  default: 0,   null: false
    t.integer  "merged_story_id",        limit: 4
  end

  add_index "stories", ["hotness"], name: "hotness_idx", using: :btree
  add_index "stories", ["is_expired", "is_moderated"], name: "is_idxes", using: :btree
  add_index "stories", ["merged_story_id"], name: "index_stories_on_merged_story_id", using: :btree
  add_index "stories", ["short_id"], name: "unique_short_id", unique: true, using: :btree
  add_index "stories", ["url"], name: "url", length: {"url"=>191}, using: :btree

  create_table "tag_filters", force: :cascade do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "user_id",    limit: 4
    t.integer  "tag_id",     limit: 4
  end

  add_index "tag_filters", ["user_id", "tag_id"], name: "user_tag_idx", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer "story_id", limit: 4, null: false
    t.integer "tag_id",   limit: 4, null: false
  end

  add_index "taggings", ["story_id", "tag_id"], name: "story_id_tag_id", unique: true, using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "tag",         limit: 25,  default: "",    null: false
    t.string  "description", limit: 100
    t.boolean "privileged",  limit: 1,   default: false
    t.boolean "is_media",    limit: 1,   default: false
    t.boolean "inactive",    limit: 1,   default: false
  end

  add_index "tags", ["tag"], name: "tag", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",             limit: 50
    t.string   "email",                limit: 100
    t.string   "password_digest",      limit: 75
    t.datetime "created_at"
    t.boolean  "email_notifications",  limit: 1,        default: false
    t.boolean  "is_admin",             limit: 1,        default: false
    t.string   "password_reset_token", limit: 75
    t.string   "session_token",        limit: 75,       default: "",    null: false
    t.text     "about",                limit: 16777215
    t.integer  "invited_by_user_id",   limit: 4
    t.boolean  "email_replies",        limit: 1,        default: false
    t.boolean  "pushover_replies",     limit: 1,        default: false
    t.string   "pushover_user_key",    limit: 255
    t.string   "pushover_device",      limit: 255
    t.boolean  "email_messages",       limit: 1,        default: true
    t.boolean  "pushover_messages",    limit: 1,        default: true
    t.boolean  "is_moderator",         limit: 1,        default: false
    t.boolean  "email_mentions",       limit: 1,        default: false
    t.boolean  "pushover_mentions",    limit: 1,        default: false
    t.string   "rss_token",            limit: 75
    t.string   "mailing_list_token",   limit: 75
    t.integer  "mailing_list_mode",    limit: 4,        default: 0
    t.integer  "karma",                limit: 4,        default: 0,     null: false
    t.datetime "banned_at"
    t.integer  "banned_by_user_id",    limit: 4
    t.string   "banned_reason",        limit: 200
    t.datetime "deleted_at"
    t.string   "pushover_sound",       limit: 255
    t.string   "weblog_feed_url",      limit: 255
  end

  add_index "users", ["mailing_list_mode"], name: "mailing_list_enabled", using: :btree
  add_index "users", ["mailing_list_token"], name: "mailing_list_token", unique: true, using: :btree
  add_index "users", ["password_reset_token"], name: "password_reset_token", unique: true, using: :btree
  add_index "users", ["rss_token"], name: "rss_token", unique: true, using: :btree
  add_index "users", ["session_token"], name: "session_hash", unique: true, using: :btree
  add_index "users", ["username"], name: "username", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer "user_id",    limit: 4, null: false
    t.integer "story_id",   limit: 4, null: false
    t.integer "comment_id", limit: 4
    t.integer "vote",       limit: 1, null: false
    t.string  "reason",     limit: 1
  end

  add_index "votes", ["user_id", "comment_id"], name: "user_id_comment_id", using: :btree
  add_index "votes", ["user_id", "story_id"], name: "user_id_story_id", using: :btree

  create_table "weblogs", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    limit: 4
    t.string   "title",      limit: 512
    t.string   "url",        limit: 512
    t.string   "site_title", limit: 512
    t.string   "site_url",   limit: 512
    t.text     "content",    limit: 16777215
    t.text     "tags",       limit: 65535
    t.string   "uuid",       limit: 200
  end

  add_index "weblogs", ["user_id", "uuid"], name: "user_and_uuid", unique: true, using: :btree

end
