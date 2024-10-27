# frozen_string_literal: true

class SignInController < ApplicationController
  def create
    carrier = Carrier.find_or_create_by(company_name: params[:company_name])
    cookies[:carrier_id] = { value: carrier.id, expires: 1.day.from_now }

    redirect_to root_path, flash: { success: 'You are logged in' }
  end

  def destroy
    cookies[:carrier_id] = nil
    redirect_to root_path, flash: { success: 'You are logged out' }
  end
end
