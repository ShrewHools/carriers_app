# frozen_string_literal: true

class ShippingRoute < ApplicationRecord
  has_many :bids, dependent: :destroy

  validates :origin, presence: true, uniqueness: { scope: :destination }, length: { maximum: 256 }
  validates :destination, presence: true, length: { maximum: 256 }
end
