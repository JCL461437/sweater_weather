class User < ApplicationRecord
  validates_presence_of :email, :password, :api_key
  
  validates_uniqueness_of :email, :api_key

  has_secure_password

  before_create :create_api_key

  has_secure_password

  private
  
  def create_api_key
    self.api_key = SecureRandom.hex
  end
end