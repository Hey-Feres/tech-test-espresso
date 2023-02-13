# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable, :timeoutable

  validate :password_matches_criteria

  private

  def password_matches_criteria
    return unless password

    if self.password.count('a-z') == 0
      self.errors.add(:password, 'must have at least 1 lower case character')
    end

    if self.password.count('A-Z') == 0
      self.errors.add(:password, 'must have at least 1 upper case character')
    end

    if self.password.scan(/[!@#$%^&*()_+{}\[\]:;'"\/\\?><.,]/)&.size == 0
      self.errors.add(:password, 'must have at least 1 special character')
    end

    if self.password.count('0-9') == 0
      self.errors.add(:password, 'must have at least 1 special character')
    end
  end
end
