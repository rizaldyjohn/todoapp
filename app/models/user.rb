require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  has_many :tasks

  # has_many :comments
  # has_many :answers

  attr_accessor :old_password, :new_password

  has_secure_password

  # validates :first_name, presence: true
  # validates :last_name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  # validates :status, presence: true, inclusion: %w[active banned]
  #
  # before_save :create_remember_token
  #
  # def full_name
  #   "#{self.first_name.capitalize} #{self.last_name.capitalize}"
  # end
  #
  # private
  #
  # def create_remember_token
  #   self.remember_token = SecureRandom.urlsafe_base64
  # end
end
