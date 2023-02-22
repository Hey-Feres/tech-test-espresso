# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  before(:each) do
    devise_setup
  end

	context	'GET /' do
		describe 'unauthenticated user' do
		  it 'is redirected to new session path' do
		    get :index
		    response.should redirect_to(new_user_session_path)
		  end
		end

		describe 'authenticated user without MFA enabled' do
		  it 'access the home route successfully' do
		  	user = create(:user)
		  	sign_in(user)

		    get :index
		    response.status.should eq 200
		  end
		end

		describe 'authenticated user with MFA enabled' do
			describe 'when MFA is verified' do
			  it 'access the home route successfully' do
			  	user = create(:user, :multi_factor_authenticable)
			  	sign_in(user)
			  	cookies[:mfa_verified] = "true"

			    get :index
			    response.status.should eq 200
			  end
			end

			describe 'when MFA is not verified' do
			  it 'is redirected to verify MFA path' do
			  	user = create(:user, :multi_factor_authenticable)
			  	sign_in(user)

			    get :index
			    response.should redirect_to(mfa_verification_form_path)
			  end
			end
		end
	end
end
