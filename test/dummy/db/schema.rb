# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_02_203044) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "unilevel_settlement_contracts", force: :cascade do |t|
    t.string "contract_number"
    t.boolean "cancellation"
    t.string "customer"
    t.string "product"
    t.bigint "unilevel_settlement_provider_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "rejected", default: false
    t.integer "user_id"
    t.index ["unilevel_settlement_provider_id"], name: "index_unilevel_settlement_contract_on_provider_id"
  end

  create_table "unilevel_settlement_payout_invoices", force: :cascade do |t|
    t.string "payout_number"
    t.bigint "unilevel_settlement_payout_run_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["unilevel_settlement_payout_run_id"], name: "index_unilevel_settlement_payout_on_payout_runs_id"
  end

  create_table "unilevel_settlement_payout_records", force: :cascade do |t|
    t.decimal "amount", precision: 8, scale: 2
    t.decimal "vat", precision: 8, scale: 2
    t.bigint "level"
    t.bigint "unilevel_settlement_payout_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "unilevel_settlement_contract_id", null: false
    t.index ["unilevel_settlement_contract_id"], name: "index_unilevel_settlement_payout_record_on_contract_id"
    t.index ["unilevel_settlement_payout_id"], name: "index_unilevel_settlement_payout_record_on_payout"
  end

  create_table "unilevel_settlement_payout_runs", force: :cascade do |t|
    t.date "payout_date"
    t.date "performance_start_date"
    t.date "performance_end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "state", default: "payout_run_started"
  end

  create_table "unilevel_settlement_providers", force: :cascade do |t|
    t.string "name"
    t.boolean "inactive", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "unilevel_settlement_provisions_template_id"
    t.index ["unilevel_settlement_provisions_template_id"], name: "index_unilevel_settlement_provider_on_provision_template_id"
  end

  create_table "unilevel_settlement_provisions", force: :cascade do |t|
    t.decimal "provision"
    t.integer "level"
    t.bigint "unilevel_settlement_provider_id"
    t.bigint "unilevel_settlement_provisions_template_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["unilevel_settlement_provider_id"], name: "index_unilevel_settlement_provisions_on_provider_id"
    t.index ["unilevel_settlement_provisions_template_id"], name: "index_unilevel_settlement_provisions_on_provisions_template_id"
  end

  create_table "unilevel_settlement_provisions_templates", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "unilevel_settlement_contracts", "unilevel_settlement_providers"
  add_foreign_key "unilevel_settlement_payout_invoices", "unilevel_settlement_payout_runs"
  add_foreign_key "unilevel_settlement_payout_records", "unilevel_settlement_contracts"
  add_foreign_key "unilevel_settlement_payout_records", "unilevel_settlement_payout_invoices", column: "unilevel_settlement_payout_id"
  add_foreign_key "unilevel_settlement_provisions", "unilevel_settlement_providers"
  add_foreign_key "unilevel_settlement_provisions", "unilevel_settlement_provisions_templates"
end
