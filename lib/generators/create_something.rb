class CreateSafaris < ActiveRecord::Migration
  def self.up
    create_table "safaris", force: :cascade do |t|
    t.string   "product_name"
    t.string   "product_type"
    t.text     "product_date"
    t.string   "image"
    t.string   "pricing"
    t.integer  "days"
    t.text     "itinerary"
    t.text     "description"
    t.text     "product_address"
    t.string   "url"
    t.integer  "destination_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end
  end

  def self.down
    drop_table :safaris
  end
end