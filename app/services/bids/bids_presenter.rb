# frozen_string_literal: true

module Bids
  class BidsPresenter
    attr_reader :bid_details

    def initialize(carrier)
      @carrier = carrier
    end

    def gather_data
      @bid_details = @carrier.bids.includes(:shipping_route, :load_type).order(:shipping_route_id).map do |bid|
        lowest_bid = lowest_bids[[bid.load_type_id, bid.shipping_route_id]]
        Bids::Detail.new(bid, lowest_bid)
      end

      self
    end

    def on_present
      yield if @bid_details.present?
    end

    def on_empty
      yield if @bid_details.blank?
    end

    private

    def lowest_bids
      @lowest_bids ||= Bid.group(:load_type_id, :shipping_route_id).minimum(:price)
    end
  end
end
