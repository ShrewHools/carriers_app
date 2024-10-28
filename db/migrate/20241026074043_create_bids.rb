# frozen_string_literal: true

class CreateBids < ActiveRecord::Migration[6.1]
  def change
    create_table :bids do |t|
      t.references :carrier, null: false, foreign_key: true, index: true
      t.references :shipping_route, null: false, foreign_key: true, index: true
      t.references :load_type, null: false, foreign_key: true, index: true
      t.decimal :price, null: false, precision: 10, scale: 2

      t.timestamps
    end
  end
end
