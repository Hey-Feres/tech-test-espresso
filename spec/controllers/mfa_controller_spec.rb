# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MfaController, type: :controller do
  context 'POST /mfa/create' do
    let!(:user) {create(:user)}
    let!(:totp) {ROTP::TOTP.new("base32secret3232", issuer: "Espresso Tech Test")}
    let(:action) {:create}

    before(:each) do
      devise_setup
      sign_in(user)
    end

    describe 'with valid code' do
      it 'enables MFA for current_user' do
        post action, params: {code: totp.now}
        user.multi_factor_authenticable.should eq true
      end

      include_examples 'Set MFA verified cookie'
      include_examples 'Redirect to mfa_new_path after post request'
    end

    describe 'with invalid code' do
      it 'not enable MFA for current_user' do
        post action, params: {code: '111111'}
        user.multi_factor_authenticable.should eq nil
      end

      include_examples 'Redirect to mfa_new_path after post request'
    end
  end

  context 'PUT /mfa/update' do
    let!(:user) {create(:user, :multi_factor_authenticable)}
    let!(:totp) {ROTP::TOTP.new("base32secret3232", issuer: "Espresso Tech Test")}
    let(:action) {:update}

    before(:each) do
      devise_setup
      sign_in(user, with_mfa: true)
    end

    it 'disable MFA from current_user' do
      put action
      user.multi_factor_authenticable.should eq nil
    end

    include_examples 'Redirect to mfa_new_path after put request'
  end

  context 'POST /mfa/verify' do
    let!(:user) {create(:user, :multi_factor_authenticable)}
    let!(:totp) {ROTP::TOTP.new("base32secret3232", issuer: "Espresso Tech Test")}
    let(:action) {:verify}

    before(:each) do
      devise_setup
      sign_in(user)
    end

    describe 'with valid code' do
      it 'redirects to root_path' do
        post action, params: {code: totp.now}
        response.should redirect_to(root_path)
      end

      include_examples 'Set MFA verified cookie'
    end

    describe 'with invalid code' do
      it 'redirects to destroy_user_session_path' do
        post action, params: {code: '111111'}
        response.should redirect_to(destroy_user_session_path)
      end
    end
  end
end
