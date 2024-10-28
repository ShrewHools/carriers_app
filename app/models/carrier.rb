# frozen_string_literal: true

class Carrier < ApplicationRecord
  has_many :bids, dependent: :destroy

  validates :company_name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 256 }
end
