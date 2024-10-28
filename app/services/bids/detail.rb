# frozen_string_literal: true

module Bids
  class Detail
    include ActionView::Helpers::NumberHelper

    attr_reader :bid, :lowest_bid

    def initialize(bid, lowest_bid)
      @bid = bid
      @lowest_bid = lowest_bid
    end

    def route
      "#{bid.shipping_route.origin} → #{bid.shipping_route.destination}"
    end

    def load_type
      bid.load_type.name
    end

    def price
      format_price(bid.price)
    end

    def lowest_price
      format_price(lowest_bid)
    end

    def on_win
      yield if bid.price <= lowest_bid
    end

    def on_lose
      yield if bid.price > lowest_bid
    end

    private

    def format_price(value)
      "#{number_with_precision(value, precision: 2)} $"
    end
  end
end
