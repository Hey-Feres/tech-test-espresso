# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_mfa!

  def index
  end
end
