# frozen_string_literal: true

class CreateCarriers < ActiveRecord::Migration[6.1]
  def change
    create_table :carriers do |t|
      t.string :company_name, null: false
    end
  end
end
