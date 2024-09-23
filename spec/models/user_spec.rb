require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }

    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:api_key).allow_nil }
  end

  describe "instance methods" do

    it "generates an api key before the user is created" do
      user = User.create!(email: "theguy@theguy.com", password: "notmypassword")
      expect(user.api_key).not_to be_nil
      expect(user.api_key.length).to eq(32)
    end

    it "generates unique api keys for different users" do
      user1 = User.create!(email: "theotherdude@theotherdude.com", password: "totallymypassword123")
      user2 = User.create!(email: "maybeaguy@maybeaguy.com", password: "couldbemypassword")
      
      expect(user1.api_key).not_to eq(user2.api_key)
    end
  end
end
