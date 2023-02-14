# frozen_string_literal: true

class ApplicationController < ActionController::Base
	def validate_mfa!
		return unless should_ask_for_mfa_code?
		redirect_to mfa_verification_form_path
	end

	def should_ask_for_mfa_code?
		(current_user.multi_factor_authenticable && cookies[:mfa_verified] != 'true')
	end
end
