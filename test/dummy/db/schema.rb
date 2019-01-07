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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "access_rights", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.string "description"
    t.integer "lock_version", default: 0, null: false
  end

  create_table "formats", force: :cascade do |t|
    t.string "name", null: false
    t.string "category"
    t.string "description"
    t.string "mime_types", array: true
    t.string "puids", array: true
    t.string "extensions", array: true
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["category"], name: "index_formats_on_category"
    t.index ["extensions"], name: "index_formats_on_extensions", using: :gin
    t.index ["mime_types"], name: "index_formats_on_mime_types", using: :gin
    t.index ["name"], name: "index_formats_on_name", unique: true
    t.index ["puids"], name: "index_formats_on_puids", using: :gin
  end

  create_table "ingest_agreements", force: :cascade do |t|
    t.string "name", null: false
    t.string "project_name"
    t.string "collection_name"
    t.string "contact_ingest", array: true
    t.string "contact_collection", array: true
    t.string "contact_system", array: true
    t.string "collection_description"
    t.string "ingest_job_name"
    t.string "collector"
    t.bigint "organization_id"
    t.bigint "ingest_model_id"
    t.integer "lock_version", default: 0, null: false
    t.index ["ingest_model_id"], name: "index_ingest_agreements_on_ingest_model_id"
    t.index ["name"], name: "index_ingest_agreements_on_name", unique: true
    t.index ["organization_id"], name: "index_ingest_agreements_on_organization_id"
  end

  create_table "ingest_models", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "entity_type"
    t.string "user_a"
    t.string "user_b"
    t.string "user_c"
    t.string "identifier"
    t.string "status"
    t.jsonb "manifestations", array: true
    t.bigint "access_right_id", null: false
    t.bigint "retention_policy_id", null: false
    t.bigint "template_id"
    t.integer "lock_version", default: 0, null: false
    t.index ["access_right_id"], name: "index_ingest_models_on_access_right_id"
    t.index ["manifestations"], name: "index_ingest_models_on_manifestations", using: :gin
    t.index ["name"], name: "index_ingest_models_on_name", unique: true
    t.index ["retention_policy_id"], name: "index_ingest_models_on_retention_policy_id"
    t.index ["template_id"], name: "index_ingest_models_on_template_id"
  end

  create_table "ingests", force: :cascade do |t|
    t.string "name", null: false
    t.string "stage"
    t.string "status"
    t.string "base_dir"
    t.bigint "ingest_agreement_id"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "lock_version", default: 0, null: false
    t.index ["ingest_agreement_id"], name: "index_ingests_on_ingest_agreement_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "type", null: false
    t.string "name", null: false
    t.string "label"
    t.bigint "parent_id"
    t.bigint "ingest_id"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "lock_version", default: 0, null: false
    t.index ["ingest_id"], name: "index_items_on_ingest_id"
    t.index ["parent_id"], name: "index_items_on_parent_id"
  end

  create_table "jwt_blacklist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_blacklist_on_jti", unique: true
  end

  create_table "material_flows", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.string "inst_code"
    t.string "description"
    t.integer "lock_version", default: 0, null: false
    t.index ["inst_code", "name"], name: "index_material_flows_on_inst_code_and_name", unique: true
  end

  create_table "memberships", force: :cascade do |t|
    t.uuid "user_id"
    t.bigint "organization_id"
    t.string "role_id"
    t.integer "lock_version", default: 0, null: false
    t.index ["organization_id"], name: "index_memberships_on_organization_id"
    t.index ["role_id"], name: "index_memberships_on_role_id"
    t.index ["user_id", "organization_id", "role_id"], name: "index_memberships_on_user_id_and_organization_id_and_role_id", unique: true
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "inst_code"
    t.string "ingest_dir"
    t.jsonb "upload_areas", default: "{}", null: false
    t.bigint "producer_id"
    t.bigint "material_flow_id"
    t.integer "lock_version", default: 0, null: false
    t.index ["material_flow_id"], name: "index_organizations_on_material_flow_id"
    t.index ["name"], name: "index_organizations_on_name", unique: true
    t.index ["producer_id"], name: "index_organizations_on_producer_id"
    t.index ["upload_areas"], name: "index_organizations_on_upload_areas", using: :gin
  end

  create_table "producers", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.string "inst_code", null: false
    t.string "description"
    t.string "agent", null: false
    t.string "password", null: false
    t.integer "lock_version", default: 0, null: false
    t.index ["inst_code", "name"], name: "index_producers_on_inst_code_and_name", unique: true
  end

  create_table "representation_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "preservation_type", null: false
    t.string "usage_type"
    t.string "representation_code"
    t.integer "lock_version", default: 0, null: false
    t.index ["name"], name: "index_representation_types_on_name", unique: true
    t.index ["preservation_type"], name: "index_representation_types_on_preservation_type"
  end

  create_table "retention_policies", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.string "description"
    t.integer "lock_version", default: 0, null: false
  end

  create_table "roles", primary_key: "code", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.integer "lock_version", default: 0, null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "status_logs", force: :cascade do |t|
    t.string "task"
    t.string "status"
    t.integer "progess"
    t.integer "max"
    t.bigint "item_id"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["item_id"], name: "index_status_logs_on_item_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lock_version", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "ingest_agreements", "ingest_models"
  add_foreign_key "ingest_agreements", "organizations"
  add_foreign_key "ingest_models", "access_rights"
  add_foreign_key "ingest_models", "ingest_models", column: "template_id"
  add_foreign_key "ingest_models", "retention_policies"
  add_foreign_key "ingests", "ingest_agreements"
  add_foreign_key "items", "ingests"
  add_foreign_key "items", "items", column: "parent_id", on_delete: :cascade
  add_foreign_key "memberships", "organizations"
  add_foreign_key "memberships", "roles", primary_key: "code"
  add_foreign_key "memberships", "users"
  add_foreign_key "organizations", "material_flows"
  add_foreign_key "organizations", "producers"
  add_foreign_key "status_logs", "items"
end
