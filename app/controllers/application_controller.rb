# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_carrier

  before_action :current_carrier

  def current_carrier
    @current_carrier ||= Carrier.find_by(id: cookies[:carrier_id])
  end

  def check_login
    redirect_to root_path unless current_carrier
  end
end
