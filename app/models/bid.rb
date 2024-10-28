# frozen_string_literal: true

class Bid < ApplicationRecord
  belongs_to :carrier
  belongs_to :shipping_route
  belongs_to :load_type

  validates :price, presence: true
  validates :carrier_id, uniqueness: { scope: %i[load_type_id shipping_route_id] }
end
