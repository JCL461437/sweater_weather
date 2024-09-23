class User < ApplicationRecord
  has_secure_password
  
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :api_key, uniqueness: true, allow_nil: true
  
  before_create :create_api_key

  private
  
  def create_api_key
    if self.api_key.nil?
      self.api_key = SecureRandom.hex(16)
    end
  end
end