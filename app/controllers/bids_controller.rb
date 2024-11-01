# frozen_string_literal: true

class BidsController < ApplicationController
  include ActionView::Helpers::NumberHelper

  before_action :check_login
  before_action :set_bid, only: %i[edit update destroy]

  def index
    @bids_presenter = Bids::BidsPresenter.new(current_carrier).gather_data
  end

  def new
    @bid = Bid.new
  end

  def create
    @bid = current_carrier.bids.new(bid_params)

    if @bid.save
      redirect_to bids_path, flash: { success: I18n.t('bids.created') }
    else
      flash.now[:danger] = @bid.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit; end

  def update
    if @bid.update(bid_params)
      redirect_to bids_path, flash: { success: I18n.t('bids.updated') }
    else
      flash.now[:danger] = @bid.errors.full_messages.to_sentence
      render :edit
    end
  end

  def fetch_lowest_bid
    route = params[:route]
    load_type = params[:load_type]
    return render json: { error: I18n.t('bids.route_load_not_found') }, status: 404 if route.blank? || load_type.blank?

    lowest_bid = Bid.where(shipping_route_id: route, load_type_id: load_type).minimum(:price)
    return render json: { error: I18n.t('bids.not_found_combination') }, status: 404 unless lowest_bid

    render json: { lowestBid: number_with_precision(lowest_bid, precision: 2) }, status: 200
  end

  def destroy
    if @bid.destroy
      redirect_to bids_path, flash: { success: I18n.t('bids.deleted') }
    else
      redirect_to bids_path, flash: { danger: @bid.errors.full_messages.to_sentence }
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:shipping_route_id, :load_type_id, :price)
  end

  def set_bid
    @bid = current_carrier.bids.find_by(id: params[:id])
    redirect_to root_path, alert: I18n.t('bids.not_found') unless @bid
  end
end
