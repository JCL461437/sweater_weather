class User < ApplicationRecord
  has_secure_password
  before_create :create_api_key
  
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :api_key, uniqueness: true, allow_nil: true
  

  private
  
  def create_api_key
    self.api_key ||= SecureRandom.hex(16)
  end
end