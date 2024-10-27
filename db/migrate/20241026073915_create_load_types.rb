# frozen_string_literal: true

class CreateLoadTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :load_types do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
