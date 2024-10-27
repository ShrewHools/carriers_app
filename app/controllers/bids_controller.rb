# frozen_string_literal: true

class BidsController < ApplicationController
  def index
    @bids_presenter = Bids::BidsPresenter.new(Carrier.first).gather_data
  end
end
