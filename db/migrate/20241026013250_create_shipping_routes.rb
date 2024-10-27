# frozen_string_literal: true

class CreateShippingRoutes < ActiveRecord::Migration[6.1]
  def change
    create_table :shipping_routes do |t|
      t.string :origin, null: false
      t.string :destination, null: false
      t.timestamps
    end

    add_index :shipping_routes, %i[origin destination], unique: true
  end
end
