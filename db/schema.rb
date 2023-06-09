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

ActiveRecord::Schema[7.0].define(version: 202304041146911) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conversations", force: :cascade do |t|
    t.string "client_phone_number", null: false
    t.string "business_phone_number", null: false
    t.datetime "latest_message_sent_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "keywords", default: [], array: true
    t.datetime "first_message_dispatched_at", precision: nil
    t.datetime "latest_outgoing_sent_at", precision: nil
    t.index ["client_phone_number", "business_phone_number"], name: "index_conversations_phone_pair_unique", unique: true
    t.index ["client_phone_number", "first_message_dispatched_at"], name: "first_msg_dispatch_client_number_idx_context"
    t.index ["client_phone_number"], name: "index_conversations_on_client_phone_number"
    t.index ["keywords", "first_message_dispatched_at"], name: "first_msg_dispatch_keywords_idx_content"
    t.index ["keywords"], name: "index_conversations_on_keywords"
    t.index ["latest_message_sent_at"], name: "index_conversations_on_latest_message_sent_at"
    t.index ["latest_outgoing_sent_at"], name: "index_conversations_on_latest_outgoing_sent_at"
  end

  create_table "fb_events", force: :cascade do |t|
    t.jsonb "data", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "conversation_id"
    t.string "body", null: false
    t.jsonb "meta", null: false
    t.boolean "outgoing", null: false
    t.datetime "sent_at", precision: nil
    t.boolean "read", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "delivered_at", precision: nil
    t.datetime "dispatched_at", precision: nil
    t.string "wa_id", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["meta"], name: "index_messages_on_meta"
    t.index ["wa_id"], name: "index_messages_on_wa_id", unique: true
  end

  create_table "raw_events", force: :cascade do |t|
    t.jsonb "data", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "messages", "conversations"
end
