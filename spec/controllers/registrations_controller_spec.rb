# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Devise::RegistrationsController, type: :controller do
	context 'POST /users' do
		before { @request.env["devise.mapping"] = Devise.mappings[:user] }

    describe 'with valid password' do
      it 'add an user' do
      	old_count = User.count
        post :create, params: {user:{email:'bruno@test.com', password: 'Aa@123456789', password_confirmation: 'Aa@123456789'}}
        User.count.should eq old_count + 1
      end

      it 'redirects to root_path' do
        post :create, params: {user:{email:'bruno@test.com', password: 'Aa@123456789', password_confirmation: 'Aa@123456789'}}
        response.should redirect_to root_path
      end
    end

    describe 'with invalid password' do
      it 'does not add an user' do
      	old_count = User.count
        post :create, params: {user:{email:'bruno@test.com', password: '123456789', password_confirmation: '123456789'}}
        User.count.should eq old_count
      end
    end
	end

	context 'PUT /users' do
		let!(:user) { user = create(:user) }

	  before(:each) do
	  	@request.env["devise.mapping"] = Devise.mappings[:user]
	    devise_setup
	  end

		describe 'with authenticated user' do
      it 'updates user data' do
		  	sign_in(user)

      	old_password = user.encrypted_password
        put :update, params: {user:{current_password: user.password, password: 'Aa@123456789', password_confirmation: 'Aa@123456789'}}
        old_password.should_not eq User.find(user.id).encrypted_password
      end
		end

		describe 'with unauthenticated user' do
      it 'redirect to new_user_session_path' do
        put :update, params: {user:{password: 'Aa@123456789', password_confirmation: 'Aa@123456789'}}
        response.should redirect_to(new_user_session_path)
      end
		end
	end

	context 'DELETE /users' do
		let!(:user) { user = create(:user) }

	  before(:each) do
	  	@request.env["devise.mapping"] = Devise.mappings[:user]
	    devise_setup
	  end

	  describe 'with authenticated user' do
			it 'remove user' do
		  	sign_in(user)

      	old_count = User.count
        delete :destroy
        User.count.should eq old_count - 1
      end
	  end

		describe 'with unauthenticated user' do
      it 'redirect to new_user_session_path' do
        delete :destroy
        response.should redirect_to(new_user_session_path)
      end
		end
	end
end
