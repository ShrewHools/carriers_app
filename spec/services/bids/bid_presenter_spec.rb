# frozen_string_literal: true

require 'spec_helper'

describe Bids::BidsPresenter do
  subject(:presenter) { described_class.new(carrier) }

  let(:carrier) { create(:carrier, company_name: 'test1') }

  let(:shipping_route) { create(:shipping_route, origin: 'Berlin', destination: 'Warsaw') }
  let(:load_type) { create(:load_type, name: '5 pallets') }
  let!(:bid) { create(:bid, carrier: carrier, load_type: load_type, shipping_route: shipping_route, price: 1000.00) }

  describe '#gather_data' do
    it 'gathers bid details and creates Bids::Detail objects' do
      presenter.gather_data
      expect(presenter.bid_details).not_to be_empty
      expect(presenter.bid_details.first).to be_a(Bids::Detail)
    end
  end

  describe '#on_present' do
    context 'when bid details are present' do
      it 'yields control' do
        presenter.gather_data
        expect { |b| presenter.on_present(&b) }.to yield_control
      end
    end

    context 'when bid details are empty' do
      it 'does not yield control' do
        expect { |b| presenter.on_present(&b) }.not_to yield_control
      end
    end
  end

  describe '#on_empty' do
    context 'when bid details are empty' do
      it 'yields control' do
        expect { |b| presenter.on_empty(&b) }.to yield_control
      end
    end

    context 'when bid details are present' do
      it 'does not yield control' do
        presenter.gather_data
        expect { |b| presenter.on_empty(&b) }.not_to yield_control
      end
    end
  end

  describe '#lowest_bids' do
    it 'returns a hash of the lowest bids grouped by load_type_id and shipping_route_id' do
      lowest_bids = presenter.send(:lowest_bids)
      expect(lowest_bids).to eq({ [load_type.id, shipping_route.id] => 1000.00 })
    end
  end
end
