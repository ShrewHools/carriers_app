# frozen_string_literal: true

require 'spec_helper'

describe Bids::Detail do
  include ActionView::Helpers::NumberHelper

  subject { described_class.new(bid, lowest_bid) }

  let(:bid) { create(:bid, carrier: carrier, load_type: load_type, shipping_route: shipping_route, price: 1000.00) }
  let(:lowest_bid) { 2000.00 }
  let(:carrier) { create(:carrier, company_name: 'test1') }
  let(:load_type) { create(:load_type, name: '5 pallets') }
  let(:shipping_route) { create(:shipping_route, origin: 'Berlin', destination: 'Warsaw') }

  it '#route' do
    expect(subject.route).to eq('Berlin → Warsaw')
  end

  it '#load_type' do
    expect(subject.load_type).to eq(load_type.name)
  end

  it '#price' do
    expect(subject.price).to eq("#{number_with_precision(bid.price, precision: 2)} $")
  end

  it '#lowest_price' do
    expect(subject.lowest_price).to eq("#{number_with_precision(lowest_bid, precision: 2)} $")
  end

  it '#on_win' do
    expect { |b| subject.on_win(&b) }.to yield_control
  end

  it '#on_lose' do
    expect { |b| subject.on_lose(&b) }.not_to yield_control
  end
end
