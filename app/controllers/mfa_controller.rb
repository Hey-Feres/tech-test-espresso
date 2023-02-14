# frozen_string_literal: true

class MfaController < ApplicationController
  before_action :validate_mfa!, only: %i[new create update]

  def verification_form
  end

  def verify
    totp = ROTP::TOTP.new("base32secret3232", issuer: "Espresso Tech Test")

    if params[:code] == totp.now
      cookies[:mfa_verified] = "true"
      redirect_to root_path, notice: "Signed In"
    else
      redirect_to destroy_user_session_path, notice: 'Invalid MFA code'
    end
  end

  def new
  end

  def create
    totp = ROTP::TOTP.new("base32secret3232", issuer: "Espresso Tech Test")

    if params[:code] == totp.now
      cookies[:mfa_verified] = "true"
      current_user.update(multi_factor_authenticable: true)
      redirect_to mfa_new_path, notice: 'MFA Ready!'
    else
      redirect_to mfa_new_path, notice: 'Invalid code'
    end
  end

  def update
    current_user.update(multi_factor_authenticable: nil)
    redirect_to mfa_new_path, notice: 'MFA Removed'
  end
end

