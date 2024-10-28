# frozen_string_literal: true

class LoadType < ApplicationRecord
  has_many :bids, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 256 }
end
