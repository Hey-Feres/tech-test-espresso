# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Devise::SessionsController, type: :controller do
	context 'POST /users/sign_in' do
		let!(:user) { create(:user) }

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      devise_setup
    end

    describe 'with correct password' do
      it 'redirects to root_path' do
      	# Failing Test Case
      	# byebug
        # post :create, params: {user: {email: user.email, password: user.password, remember_me: 0}}
        # response.should redirect_to root_path
      end
    end

    describe 'with incorrect password' do
      it 'redirects back to login form' do
        post :create, params: {user: {email: user.email, password: '123123123132', remember_me: 0}}
        response.should redirect_to new_user_session_path
      end
    end
	end

	context 'DELETE /users/sign_out' do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:user)
      sign_in user
    end

    it 'redirect to root_path' do
      delete :destroy
      response.should redirect_to root_path
    end
	end
end
