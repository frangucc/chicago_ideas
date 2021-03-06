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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130422195310) do

  create_table "addresses", :force => true do |t|
    t.string   "street_1"
    t.string   "street_2"
    t.string   "city"
    t.string   "zip"
    t.string   "country"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
  end

  create_table "affiliate_event_applications", :force => true do |t|
    t.string   "first_name",           :null => false
    t.string   "last_name",            :null => false
    t.string   "organization_name",    :null => false
    t.string   "website"
    t.string   "job_title"
    t.string   "email",                :null => false
    t.string   "phone_number",         :null => false
    t.string   "event_name",           :null => false
    t.string   "event_date",           :null => false
    t.string   "event_location",       :null => false
    t.string   "event_capacity",       :null => false
    t.text     "event_overview",       :null => false
    t.string   "recurring"
    t.string   "paid_event"
    t.string   "event_cost"
    t.string   "rsvp_required"
    t.string   "rsvp_directions"
    t.boolean  "promote_event",        :null => false
    t.boolean  "event_info_available", :null => false
    t.boolean  "not_make_changes",     :null => false
    t.integer  "user_id",              :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description_25words",  :null => false
    t.text     "description_10words",  :null => false
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
  end

  add_index "affiliate_event_applications", ["user_id"], :name => "index_affiliate_event_applilcations_on_user_id"

  create_table "bhsi_applications", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",                           :limit => 25,       :default => "",    :null => false
    t.string   "last_name",                            :limit => 25,       :default => "",    :null => false
    t.string   "address1",                             :limit => 100,      :default => "",    :null => false
    t.string   "address2",                             :limit => 55
    t.string   "city",                                 :limit => 55,       :default => "",    :null => false
    t.string   "state",                                :limit => 15,       :default => "",    :null => false
    t.string   "country",                                                  :default => "US",  :null => false
    t.string   "email",                                :limit => 50,       :default => "",    :null => false
    t.string   "gender",                               :limit => 10,       :default => "",    :null => false
    t.text     "birthdate",                            :limit => 16777215,                    :null => false
    t.string   "title",                                :limit => 50,       :default => "",    :null => false
    t.text     "social_venture_name",                  :limit => 16777215,                    :null => false
    t.string   "legal_structure",                      :limit => 100,      :default => "",    :null => false
    t.string   "url",                                  :limit => 100,      :default => "",    :null => false
    t.string   "twitter_handle",                       :limit => 20,       :default => "",    :null => false
    t.text     "video_url",                            :limit => 16777215,                    :null => false
    t.string   "applied_before",                       :limit => 3,        :default => "",    :null => false
    t.text     "about_yourself",                       :limit => 16777215
    t.text     "social_venture_description",           :limit => 16777215
    t.text     "venture_launched",                     :limit => 16777215
    t.text     "number_people_affected",               :limit => 16777215
    t.text     "explain_number",                       :limit => 16777215
    t.text     "organizational_development",           :limit => 16777215
    t.text     "makes_social_innovation",              :limit => 16777215
    t.text     "inspiration",                          :limit => 16777215
    t.text     "sustainability_model",                 :limit => 16777215
    t.text     "improvements",                         :limit => 16777215
    t.text     "distinguish_yourself",                 :limit => 16777215
    t.text     "strong_midwest_connections_explained", :limit => 16777215
    t.text     "additional_comments",                  :limit => 16777215
    t.string   "reference_1_name",                     :limit => 50,       :default => "",    :null => false
    t.string   "reference_1_relationship",             :limit => 100,      :default => "",    :null => false
    t.string   "reference_1_phone",                                        :default => "",    :null => false
    t.string   "reference_1_email",                    :limit => 50,       :default => "",    :null => false
    t.string   "reference_2_name",                     :limit => 50,       :default => "",    :null => false
    t.string   "reference_2_relationship",             :limit => 100,      :default => "",    :null => false
    t.string   "reference_2_phone",                                        :default => "",    :null => false
    t.string   "reference_2_email",                    :limit => 50,       :default => "",    :null => false
    t.integer  "user_id"
    t.text     "three_standout_statistics",            :limit => 16777215
    t.boolean  "agreement_accepeted",                                      :default => false, :null => false
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
    t.string   "phone_number",                                             :default => "",    :null => false
    t.string   "previous_budget_file_name"
    t.string   "previous_budget_content_type"
    t.integer  "previous_budget_file_size"
    t.datetime "previous_budget_updated_at"
    t.string   "press_clipping_1_file_name"
    t.string   "press_clipping_1_content_type"
    t.integer  "press_clipping_1_file_size"
    t.datetime "press_clipping_1_updated_at"
    t.string   "press_clipping_2_file_name"
    t.string   "press_clipping_2_content_type"
    t.integer  "press_clipping_2_file_size"
    t.datetime "press_clipping_2_updated_at"
    t.string   "press_clipping_3_file_name"
    t.string   "press_clipping_3_content_type"
    t.integer  "press_clipping_3_file_size"
    t.datetime "press_clipping_3_updated_at"
    t.string   "zipcode",                              :limit => 11,       :default => "",    :null => false
    t.text     "org_join_point"
    t.text     "total_budget_current_year",                                                   :null => false
    t.text     "major_sources_income",                                                        :null => false
    t.text     "impact",                                                                      :null => false
    t.text     "obstacles_needs",                                                             :null => false
    t.string   "current_budget_file_name"
    t.string   "current_budget_content_type"
    t.integer  "current_budget_file_size"
    t.datetime "current_budget_updated_at"
    t.string   "venture_standard_deck_file_name"
    t.string   "venture_standard_deck_content_type"
    t.integer  "venture_standard_deck_file_size"
    t.datetime "venture_standard_deck_updated_at"
    t.boolean  "is_venture_not_for_profit"
    t.string   "org_founder",                          :limit => 10
  end

  create_table "bhsi_longtexts", :force => true do |t|
    t.text    "about_yourself",                       :limit => 16777215, :null => false
    t.text    "social_venture_description",           :limit => 16777215, :null => false
    t.text    "venture_launched",                     :limit => 16777215, :null => false
    t.text    "number_people_affected",               :limit => 16777215, :null => false
    t.text    "explain_number",                       :limit => 16777215, :null => false
    t.text    "organizational_development",           :limit => 16777215, :null => false
    t.text    "strong_midwest_connections_explained", :limit => 16777215
    t.text    "additional_comments",                  :limit => 16777215
    t.text    "three_standout_statistics",            :limit => 16777215, :null => false
    t.integer "bhsi_application_id"
  end

  create_table "chapter_photos", :force => true do |t|
    t.string   "photo_file_name",    :null => false
    t.string   "photo_content_type", :null => false
    t.integer  "photo_file_size",    :null => false
    t.datetime "photo_updated_at",   :null => false
    t.integer  "chapter_id",         :null => false
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chapter_photos", ["chapter_id"], :name => "index_chapter_photos_on_chapter_id"

  create_table "chapters", :force => true do |t|
    t.integer  "sort",                                            :null => false
    t.string   "title"
    t.text     "description"
    t.integer  "talk_id",                                         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "vimeo_id"
    t.boolean  "featured_on_talk",             :default => false, :null => false
    t.boolean  "featured_on_homepage",         :default => false, :null => false
    t.text     "homepage_caption"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.string   "homepage_banner_file_name"
    t.string   "homepage_banner_content_type"
    t.integer  "homepage_banner_file_size"
    t.datetime "homepage_banner_updated_at"
  end

  add_index "chapters", ["talk_id", "sort"], :name => "index_chapters_on_talk_id_and_sort"
  add_index "chapters", ["talk_id"], :name => "index_chapters_on_talk_id"

  create_table "community_partner_applications", :force => true do |t|
    t.string   "name",                                                :null => false
    t.text     "description"
    t.string   "address1",                                            :null => false
    t.string   "address2"
    t.string   "city",                                                :null => false
    t.string   "state",                                               :null => false
    t.string   "country",                           :default => "US", :null => false
    t.boolean  "public_mailing_list"
    t.integer  "user_id",                                             :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "facebook_page"
    t.string   "twitter_handle"
    t.string   "contact_name",                                        :null => false
    t.string   "contact_title",                                       :null => false
    t.string   "contact_phone",                                       :null => false
    t.string   "previous_partner",                  :default => "0",  :null => false
    t.text     "why_partner",                                         :null => false
    t.boolean  "design_with_purpose_theme"
    t.boolean  "fashion_theme"
    t.boolean  "sports_theme"
    t.boolean  "cities_theme"
    t.boolean  "politics_theme"
    t.boolean  "philanthropy_theme"
    t.boolean  "tech_theme"
    t.boolean  "breathroughs_in_science_theme"
    t.boolean  "creative_process_theme"
    t.boolean  "health_wellness_theme"
    t.boolean  "future_of_news_theme"
    t.boolean  "influence_of_art_theme"
    t.boolean  "food_theme"
    t.boolean  "social_entrepreneurship_theme"
    t.boolean  "explorers_theme"
    t.boolean  "disruptive_innovation_theme"
    t.boolean  "future_of_military_theme"
    t.boolean  "music_theme"
    t.boolean  "religion_theme"
    t.boolean  "epic_friendships_theme"
    t.boolean  "economy_theme"
    t.boolean  "future_leaders_theme"
    t.boolean  "education_theme"
    t.boolean  "meaning_of_life_theme"
    t.boolean  "earth_theme"
    t.boolean  "criminal_justice_theme"
    t.boolean  "storytellers_theme"
    t.boolean  "identity_theme"
    t.string   "most_important"
    t.string   "organization_has_newsletter"
    t.string   "organization_newsletter_frequency"
    t.boolean  "ciw_updates_in_newsletter"
    t.boolean  "will_promote_ciw",                                    :null => false
    t.boolean  "encourage_promote_ciw",                               :null => false
    t.boolean  "provide_insight_guidance",                            :null => false
    t.string   "contact_email",                                       :null => false
    t.text     "most_important_other"
    t.string   "other_newsletter_frequency"
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
    t.boolean  "instigators_theme"
  end

  add_index "community_partner_applications", ["user_id"], :name => "index_community_partner_applications_on_user_id"

  create_table "cooperative_applications", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "organization"
    t.string   "phone"
    t.text     "org_mission"
    t.string   "org_twitter"
    t.text     "reason"
    t.text     "worked_on"
    t.text     "part_meaningful"
    t.text     "ins_failure"
    t.text     "neighborhood"
    t.text     "assisted_area"
    t.text     "recommend"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
    t.string   "last_name",        :null => false
    t.string   "email",            :null => false
    t.string   "org_website",      :null => false
    t.string   "passion_1"
    t.string   "passion_2"
    t.string   "passion_3"
  end

  create_table "days", :force => true do |t|
    t.integer  "year_id",    :null => false
    t.string   "name",       :null => false
    t.date     "date",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "days", ["date"], :name => "index_days_on_date"
  add_index "days", ["year_id"], :name => "index_days_on_year_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "demographic_infos", :force => true do |t|
    t.string   "race"
    t.string   "industry"
    t.string   "income"
    t.string   "gender"
    t.string   "age"
    t.boolean  "travel",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "edison_talks_applications", :force => true do |t|
    t.string   "name",                                 :null => false
    t.string   "organization"
    t.string   "title"
    t.string   "email",                                :null => false
    t.string   "phone",                                :null => false
    t.text     "passions",         :limit => 16777215, :null => false
    t.text     "why_come",         :limit => 16777215, :null => false
    t.text     "recommendation",   :limit => 16777215, :null => false
    t.text     "invention",        :limit => 16777215, :null => false
    t.string   "inspiration_1",                        :null => false
    t.string   "inspiration_2",                        :null => false
    t.string   "inspiration_3",                        :null => false
    t.text     "comments",         :limit => 16777215
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_brands", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_brands", ["name"], :name => "index_event_brands_on_name"

  create_table "event_photos", :force => true do |t|
    t.string   "photo_file_name",    :null => false
    t.string   "photo_content_type", :null => false
    t.integer  "photo_file_size",    :null => false
    t.datetime "photo_updated_at",   :null => false
    t.integer  "event_id",           :null => false
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_photos", ["event_id"], :name => "index_event_photos_on_event_id"

  create_table "event_speakers", :force => true do |t|
    t.integer  "speaker_id", :null => false
    t.integer  "event_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_speakers", ["event_id"], :name => "index_event_speakers_on_event_id"
  add_index "event_speakers", ["speaker_id", "event_id"], :name => "index_event_speakers_on_speaker_id_and_event_id"

  create_table "events", :force => true do |t|
    t.string   "name",                  :limit => 150, :null => false
    t.text     "description"
    t.integer  "partner_id"
    t.integer  "day_id",                               :null => false
    t.integer  "venue_id",                             :null => false
    t.integer  "event_brand_id",                       :null => false
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.time     "start_time",                           :null => false
    t.time     "end_time",                             :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "twitter_hashtag"
    t.string   "ticket_url"
    t.string   "lab_host_file_name"
    t.string   "lab_host_content_type"
    t.integer  "lab_host_file_size"
    t.datetime "lab_host_updated_at"
    t.string   "lab_host_url"
  end

  add_index "events", ["day_id"], :name => "index_events_on_day_id"
  add_index "events", ["event_brand_id"], :name => "index_events_on_event_brand_id"
  add_index "events", ["partner_id"], :name => "index_events_on_partner_id"
  add_index "events", ["venue_id"], :name => "index_events_on_venue_id"

  create_table "jobs", :force => true do |t|
    t.string   "title",                        :null => false
    t.text     "body",                         :null => false
    t.string   "url"
    t.boolean  "published",  :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "materials", :force => true do |t|
    t.string   "name"
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "member_types", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "specific_benefits"
    t.integer  "min_price_in_cents", :default => 0
    t.integer  "projected_members",  :default => 0
    t.integer  "maximum_members",    :default => 0
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "max_price_in_cents", :default => 0
    t.string   "value"
    t.text     "general_benefits"
    t.integer  "year_id"
    t.string   "estimated_value"
  end

  create_table "members", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "member_type_id", :null => false
    t.integer  "year_id",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company_name"
  end

  add_index "members", ["member_type_id"], :name => "index_members_on_member_type_id"
  add_index "members", ["user_id"], :name => "index_members_on_user_id"
  add_index "members", ["year_id"], :name => "index_members_on_year_id"

  create_table "notes", :force => true do |t|
    t.integer  "author_id"
    t.text     "body",                    :null => false
    t.string   "asset_type",              :null => false
    t.integer  "asset_id",                :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["asset_type", "asset_id"], :name => "index_notes_on_asset_type_and_asset_id"
  add_index "notes", ["author_id"], :name => "index_notes_on_author_id"

  create_table "orders", :force => true do |t|
    t.integer  "total_in_cents"
    t.boolean  "approved"
    t.integer  "user_id"
    t.integer  "member_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "address_id"
    t.string   "code"
    t.string   "name_on_card"
    t.string   "an_response_reason_text"
    t.string   "an_authorization_code"
    t.string   "an_invoice_number"
    t.string   "an_account_number"
    t.string   "an_card_type"
  end

  create_table "partners", :force => true do |t|
    t.string   "name",              :limit => 100, :null => false
    t.text     "description"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "performances", :force => true do |t|
    t.integer  "speaker_id", :null => false
    t.integer  "chapter_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "performances", ["chapter_id"], :name => "index_performances_on_chapter_id"
  add_index "performances", ["speaker_id", "chapter_id"], :name => "index_performances_on_speaker_id_and_chapter_id"

  create_table "photos", :force => true do |t|
    t.string   "caption",            :null => false
    t.string   "asset_type",         :null => false
    t.integer  "asset_id",           :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["asset_type", "asset_id"], :name => "index_photos_on_asset_type_and_asset_id"

  create_table "press_clippings", :force => true do |t|
    t.string   "title",              :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "news_type"
  end

  create_table "quotes", :force => true do |t|
    t.text     "body",       :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quotes", ["user_id"], :name => "index_quotes_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "simulate_users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "user_id",                                             :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simulate_users", ["email"], :name => "index_simulate_users_on_email"
  add_index "simulate_users", ["reset_password_token"], :name => "index_simulate_users_on_reset_password_token"

  create_table "speakers", :force => true do |t|
    t.integer  "year_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sponsor_events", :force => true do |t|
    t.string   "month"
    t.string   "day"
    t.string   "name"
    t.string   "info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "year_id"
  end

  create_table "sponsor_users", :force => true do |t|
    t.integer  "sponsor_id"
    t.integer  "user_id"
    t.string   "title"
    t.string   "phone"
    t.boolean  "newsletters_subscription"
    t.boolean  "primary_contact"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "eps_logo_file_name"
    t.string   "eps_logo_content_type"
    t.integer  "eps_logo_file_size"
    t.datetime "eps_logo_updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "sponsors", :force => true do |t|
    t.string   "name",                           :limit => 150,                                                  :null => false
    t.text     "description"
    t.integer  "sponsorship_level_id",                                                                           :null => false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.boolean  "featured"
    t.integer  "sort"
    t.integer  "ciw_talks_tickets"
    t.integer  "labs_tickets"
    t.integer  "vip_reception_tickets"
    t.integer  "edison_talk_tickets"
    t.integer  "concert_tickets"
    t.decimal  "sponsorship_amount",                            :precision => 10, :scale => 0
    t.string   "eps_logo_file_name"
    t.string   "eps_logo_content_type"
    t.integer  "eps_logo_file_size"
    t.datetime "eps_logo_updated_at"
    t.string   "sponsor_agreement_file_name"
    t.string   "sponsor_agreement_content_type"
    t.integer  "sponsor_agreement_file_size"
    t.datetime "sponsor_agreement_updated_at"
    t.boolean  "locked",                                                                       :default => true
    t.integer  "menlo_passes"
  end

  add_index "sponsors", ["sponsorship_level_id"], :name => "index_sponsors_on_sponsorship_level_id"

  create_table "sponsorship_levels", :force => true do |t|
    t.string   "name",       :limit => 150, :null => false
    t.integer  "sort",                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sponsorships", :force => true do |t|
    t.integer  "sponsor_id",           :null => false
    t.integer  "year_id",              :null => false
    t.integer  "sponsorship_level_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sponsorships", ["sponsor_id"], :name => "index_sponsorships_on_sponsor_id"
  add_index "sponsorships", ["sponsorship_level_id"], :name => "index_sponsorships_on_sponsorship_level_id"
  add_index "sponsorships", ["year_id", "sponsor_id"], :name => "index_sponsorships_on_year_id_and_sponsor_id"

  create_table "talk_brands", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "talk_brands", ["name"], :name => "index_talk_brands_on_name"

  create_table "talk_photos", :force => true do |t|
    t.string   "photo_file_name",    :null => false
    t.string   "photo_content_type", :null => false
    t.integer  "photo_file_size",    :null => false
    t.datetime "photo_updated_at",   :null => false
    t.integer  "talk_id",            :null => false
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "talk_photos", ["talk_id"], :name => "index_talk_photos_on_talk_id"

  create_table "talks", :force => true do |t|
    t.string   "name",                    :limit => 150, :null => false
    t.text     "description"
    t.integer  "day_id",                                 :null => false
    t.integer  "venue_id",                               :null => false
    t.integer  "track_id"
    t.integer  "talk_brand_id",                          :null => false
    t.time     "start_time",                             :null => false
    t.time     "end_time",                               :null => false
    t.integer  "sponsor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "twitter_hashtag"
    t.string   "ticket_url"
    t.string   "transcript_file_name"
    t.string   "transcript_content_type"
    t.integer  "transcript_file_size"
    t.datetime "transcript_updated_at"
  end

  add_index "talks", ["day_id"], :name => "index_talks_on_day_id"
  add_index "talks", ["sponsor_id"], :name => "index_talks_on_sponsor_id"
  add_index "talks", ["talk_brand_id"], :name => "index_talks_on_talk_brand_id"
  add_index "talks", ["track_id"], :name => "index_talks_on_topic_id"
  add_index "talks", ["venue_id"], :name => "index_talks_on_venue_id"

  create_table "think_chicago_applications", :force => true do |t|
    t.string   "first_name",                                               :null => false
    t.string   "middle_name"
    t.string   "last_name",                                                :null => false
    t.string   "address1",                                                 :null => false
    t.string   "address2"
    t.string   "city",                                                     :null => false
    t.string   "state",                                                    :null => false
    t.string   "zip",                                                      :null => false
    t.string   "phone",                                                    :null => false
    t.string   "email",                                                    :null => false
    t.string   "how_learn",                                                :null => false
    t.string   "how_learn_extra"
    t.string   "institutions",                                             :null => false
    t.string   "field_major",                                              :null => false
    t.string   "minor"
    t.string   "dates_attended",                                           :null => false
    t.string   "gpa",                                                      :null => false
    t.string   "degree_type",                                              :null => false
    t.string   "expected_graduation_date",                                 :null => false
    t.string   "employment_interests",                                     :null => false
    t.string   "employment_interests_extra"
    t.text     "honors_experience_activities",       :limit => 16777215,   :null => false
    t.text     "qualities_attributes",               :limit => 16777215,   :null => false
    t.text     "hope_to_gain",                       :limit => 16777215,   :null => false
    t.string   "current_resume_file_name"
    t.string   "current_resume_content_type"
    t.integer  "current_resume_file_size"
    t.datetime "current_resume_updated_at"
    t.string   "unofficial_transcript_file_name"
    t.string   "unofficial_transcript_content_type"
    t.integer  "unofficial_transcript_file_size"
    t.datetime "unofficial_transcript_updated_at"
    t.string   "faculty_endorsement_file_name"
    t.string   "faculty_endorsement_content_type"
    t.integer  "faculty_endorsement_file_size"
    t.datetime "faculty_endorsement_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
    t.text     "companies",                          :limit => 2147483647, :null => false
  end

  create_table "tracks", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",                    :default => ""
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token",                                     :null => false
    t.boolean  "admin",                                 :default => false, :null => false
    t.boolean  "is_speaker",                            :default => false, :null => false
    t.boolean  "staff",                                 :default => false, :null => false
    t.boolean  "is_volunteer",                          :default => false, :null => false
    t.string   "name"
    t.string   "phone"
    t.integer  "fb_uid"
    t.string   "fb_access_token"
    t.string   "twitter_token"
    t.string   "twitter_secret"
    t.string   "title"
    t.text     "bio"
    t.string   "twitter_screen_name"
    t.string   "permalink",              :limit => 150
    t.string   "portrait_file_name"
    t.string   "portrait_content_type"
    t.integer  "portrait_file_size"
    t.datetime "portrait_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "portrait2_file_name"
    t.string   "portrait2_content_type"
    t.integer  "portrait2_file_size"
    t.datetime "portrait2_updated_at"
    t.boolean  "newsletter",                            :default => true,  :null => false
    t.boolean  "published",                             :default => false, :null => false
    t.boolean  "is_sponsor"
    t.boolean  "is_member"
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "address_id"
  end

  add_index "users", ["admin"], :name => "index_users_on_admin"
  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token"
  add_index "users", ["deleted_at"], :name => "index_users_on_deleted_at"
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["fb_access_token"], :name => "index_users_on_fb_access_token"
  add_index "users", ["fb_uid"], :name => "index_users_on_fb_uid"
  add_index "users", ["is_speaker"], :name => "index_users_on_speaker"
  add_index "users", ["is_volunteer"], :name => "index_users_on_volunteer"
  add_index "users", ["permalink"], :name => "index_users_on_permalink"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"
  add_index "users", ["staff"], :name => "index_users_on_staff"

  create_table "venues", :force => true do |t|
    t.string   "name",                :limit => 100,                   :null => false
    t.string   "address1",            :limit => 100,                   :null => false
    t.string   "address2",            :limit => 100
    t.string   "city",                :limit => 100,                   :null => false
    t.string   "state",               :limit => 100,                   :null => false
    t.string   "zipcode",             :limit => 100,                   :null => false
    t.string   "country",             :limit => 2,   :default => "US", :null => false
    t.point    "lonlat",              :limit => nil,                   :null => false
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venues", ["name"], :name => "index_venues_on_name"

  create_table "videos", :force => true do |t|
    t.string   "caption",    :null => false
    t.string   "asset_type", :null => false
    t.integer  "asset_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "videos", ["asset_type", "asset_id"], :name => "index_videos_on_asset_type_and_asset_id"

  create_table "volunteers", :force => true do |t|
    t.integer  "user_id"
    t.string   "postcode"
    t.boolean  "employed"
    t.text     "why"
    t.text     "what"
    t.text     "availability"
    t.boolean  "street_team"
    t.boolean  "avail_mon"
    t.boolean  "avail_tue"
    t.boolean  "avail_wed"
    t.boolean  "avail_thu"
    t.boolean  "avail_fri"
    t.boolean  "avail_sat"
    t.boolean  "avail_sun"
    t.boolean  "avail_time_1"
    t.boolean  "avail_time_2"
    t.boolean  "avail_time_3"
    t.boolean  "avail_time_4"
    t.boolean  "avail_time_5"
    t.boolean  "avail_time_6"
    t.string   "hours"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",                  :null => false
    t.string   "last_name",                   :null => false
    t.string   "phone",                       :null => false
    t.string   "email",                       :null => false
    t.string   "zip_code"
    t.boolean  "interested_in_promoting"
    t.string   "type_of_position"
    t.string   "specific_event_interest"
    t.boolean  "interested_in_youth_program"
    t.text     "anything_else"
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
    t.string   "organization_name_1"
    t.string   "organization_department_1"
    t.string   "organization_title_1"
    t.string   "organization_name_2"
    t.string   "organization_department_2"
    t.string   "organization_title_2"
    t.string   "organization_name_3"
    t.string   "organization_department_3"
    t.string   "organization_title_3"
    t.text     "interests_volunteering"
    t.text     "skills"
  end

  add_index "volunteers", ["user_id"], :name => "index_volunteers_on_user_id"

  create_table "years", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
