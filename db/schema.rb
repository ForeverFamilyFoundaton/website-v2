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

ActiveRecord::Schema.define(version: 2021_04_14_035116) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", id: :serial, force: :cascade do |t|
    t.string "resource_type", null: false
    t.integer "resource_id", null: false
    t.string "author_type"
    t.integer "author_id"
    t.text "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "namespace"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "addresses", id: :serial, force: :cascade do |t|
    t.string "address", limit: 500
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "addressable_type"
    t.integer "addressable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "country"
  end

  create_table "adg_answers", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "adg_question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "answer", limit: 5000
    t.string "radio_val", default: "false"
    t.string "question"
  end

  create_table "adg_questions", id: :serial, force: :cascade do |t|
    t.string "question"
    t.boolean "show_radio", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "announcements", id: :serial, force: :cascade do |t|
    t.string "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date "start_date"
    t.date "end_date"
    t.text "link"
    t.string "button"
  end

  create_table "attached_files", id: :serial, force: :cascade do |t|
    t.string "attachable_type"
    t.integer "attachable_id"
    t.string "attachment_file_name"
    t.string "attachment_content_type"
    t.string "attachment_file_size"
    t.string "attachment_updated_at"
    t.string "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "belief_type_selections", id: :serial, force: :cascade do |t|
    t.integer "belief_type_id"
    t.integer "sitterform_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "belief_types", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "billing_addresses", id: :serial, force: :cascade do |t|
    t.string "address"
    t.string "state"
    t.string "country"
    t.string "city"
    t.string "zip"
    t.integer "business_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "business_assignments", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "business_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "businesses", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "contact_name"
    t.string "contact_email"
    t.string "contact_phone"
    t.string "fax"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.text "promotional_info_additional_notes"
    t.boolean "use_business_card_for_web_banner"
    t.text "promotional_media_text"
    t.text "promotional_media_additional_notes"
    t.integer "completed_step", default: 0, null: false
    t.boolean "welcomed", default: false
    t.boolean "confirmed", default: false
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "charges", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "stripe_id"
    t.integer "amount"
    t.integer "amount_refunded"
    t.string "card_brand"
    t.string "card_last4"
    t.string "card_exp_month"
    t.string "card_exp_year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_charges_on_user_id"
  end

  create_table "cms_images", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "caption"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cms_pages", id: :serial, force: :cascade do |t|
    t.string "reference_string"
    t.string "title"
    t.string "sub_title"
    t.string "nav_text"
    t.text "body"
    t.text "meta_keywords"
    t.text "meta_description"
    t.integer "position"
    t.integer "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug"
    t.boolean "nav_item"
    t.index ["slug"], name: "index_cms_pages_on_slug", unique: true
  end

  create_table "config_variables", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "embeded_links", id: :serial, force: :cascade do |t|
    t.text "body"
    t.string "title"
    t.string "em_linkable_type"
    t.integer "em_linkable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "url"
    t.string "pic_link"
    t.text "teaser"
  end

  create_table "exports", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "file_file_name"
    t.string "file_content_type"
    t.bigint "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "external_links", id: :serial, force: :cascade do |t|
    t.string "text"
    t.string "url"
    t.integer "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "linkable_type"
    t.integer "linkable_id"
  end

  create_table "families", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "family_members", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "first_name"
    t.string "last_name"
    t.string "relationship"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "role"
    t.integer "family_id"
  end

  create_table "family_memberships", force: :cascade do |t|
    t.bigint "family_id"
    t.bigint "user_id"
    t.string "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["family_id"], name: "index_family_memberships_on_family_id"
    t.index ["user_id"], name: "index_family_memberships_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "known_deads", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "relationship_id"
    t.integer "sitterform_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "year_of_death"
  end

  create_table "mediumform_preference_selections", id: :serial, force: :cascade do |t|
    t.integer "mediumform_id"
    t.integer "mediumform_preference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mediumform_preferences", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "preference_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mediumforms", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "personalprofessional"
    t.string "alt_first_name"
    t.string "alt_middle_name"
    t.string "alt_last_name"
    t.string "alt_work_phone"
    t.string "alt_mobile_phone"
    t.string "alt_address_line1"
    t.string "alt_address_line2"
    t.string "alt_city"
    t.string "alt_state"
    t.string "alt_zipcode"
    t.string "alt_country"
    t.string "alt_email"
    t.boolean "health_healing"
    t.text "other_businesses"
    t.string "website"
    t.string "blog"
    t.string "facebook"
    t.string "pinterest"
    t.string "instagram"
    t.string "twitter"
    t.string "youtube"
    t.string "other"
    t.text "other_primary_owner"
    t.text "other_related"
    t.text "other_not_related"
    t.text "became_aware"
    t.text "immediate_family"
    t.text "life_event"
    t.text "specific_goal"
    t.text "medium_priority"
    t.text "different_info"
    t.text "hear_about_fff"
    t.text "medium_history"
    t.text "kind_of_readings"
    t.text "self_classify"
    t.text "medium_preferences"
    t.text "other_classify"
    t.text "mediumship_training"
    t.text "ethics1"
    t.text "ethics2"
    t.text "ethics3"
    t.text "ethics4"
    t.string "sitter1"
    t.string "sitter2"
    t.string "sitter3"
    t.string "sitter4"
    t.string "sitter5"
    t.string "medium_status"
    t.string "test_date"
    t.string "application_date"
    t.boolean "signature_checkbox", default: false
    t.string "signature"
    t.text "other_certification"
    t.datetime "MEPC_Removed"
    t.datetime "MEPC_Failed"
    t.text "admin_notes"
    t.string "SitterA"
    t.string "SitterB"
    t.string "SitterC"
    t.string "SitterD"
    t.string "SitterE"
    t.string "alt_home_phone"
    t.string "alt_work_email"
    t.string "alt_home_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.text "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.integer "amount"
    t.string "interval"
    t.string "stripe_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "preferences", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "preference_type"
  end

  create_table "radio_shows", id: :serial, force: :cascade do |t|
    t.string "format"
    t.date "date"
    t.string "title"
    t.string "guest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "instructions"
  end

  create_table "recommended_book_categories", id: :serial, force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recommended_book_groups", id: :serial, force: :cascade do |t|
    t.integer "recommended_book_id"
    t.integer "recommended_book_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recommended_books", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.string "amazon_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uk_amazon_link"
    t.string "cad_amazon_link"
  end

  create_table "relationships", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "typeof"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "sitterforms", id: :serial, force: :cascade do |t|
    t.string "phone"
    t.string "cell"
    t.string "alt_email"
    t.text "website"
    t.text "facebook"
    t.text "pinterest"
    t.text "instagram"
    t.text "twitter"
    t.text "youtube"
    t.text "blog"
    t.text "related_contact_info"
    t.boolean "been_to_medium"
    t.boolean "lost_loved_one"
    t.string "signature"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "relationships"
    t.integer "belief_type_id"
    t.text "medium_contacts"
    t.boolean "signature_checkbox", default: false
  end

  create_table "splash_nav_items", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.text "image_data"
    t.integer "row_order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "cms_page_id"
    t.index ["cms_page_id"], name: "index_splash_nav_items_on_cms_page_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "stripe_id"
    t.string "stripe_plan"
    t.string "status"
    t.datetime "trial_ends_at"
    t.datetime "ends_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "user_categories", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["category_id"], name: "index_user_categories_on_category_id"
    t.index ["user_id"], name: "index_user_categories_on_user_id"
  end

  create_table "user_preference_selections", force: :cascade do |t|
    t.integer "user_id"
    t.integer "preference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "encrypted_password", default: "", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "invitation_token"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "cell_phone"
    t.string "home_phone"
    t.string "work_phone"
    t.string "state"
    t.boolean "is_business", default: false
    t.string "fax"
    t.string "enrolled_from"
    t.integer "welcomed", default: 0, null: false
    t.boolean "confirmed", default: false
    t.string "email"
    t.boolean "do_not_mail"
    t.integer "membership_number"
    t.text "problems"
    t.datetime "enrolled_at"
    t.boolean "snail_mail", default: false, null: false
    t.boolean "sitter_registration", default: false
    t.boolean "medium_registration", default: false
    t.datetime "discarded_at"
    t.string "unconfirmed_email"
    t.string "stripe_subscription_id"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.integer "invitations_count", default: 0
    t.string "stripe_id"
    t.string "card_brand"
    t.string "card_last4"
    t.string "card_exp_month"
    t.string "card_exp_year"
    t.index ["discarded_at"], name: "index_users_on_discarded_at"
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "charges", "users"
  add_foreign_key "subscriptions", "users"
end
