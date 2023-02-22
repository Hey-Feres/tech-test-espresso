# frozen_string_literal: true

Faker::Config.locale = 'pt-BR'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'Aa#1234567890' }

    trait :multi_factor_authenticable do
      multi_factor_authenticable { true }
    end
  end
end