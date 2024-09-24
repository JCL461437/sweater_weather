require "rails_helper"

RSpec.describe 'User Creation Request for POST /api/v1/users endpoint' do
  describe "happy path" do
    it "can create a new user" do
      valid_user = {
        email: "theguy@theguy.com",
        password: "notmypassword",
        password_confirmation: "notmypassword"
      }

      post "/api/v1/users", params: valid_user.to_json, headers: { 'CONTENT_TYPE' => 'application/json' } #v converts valid_user to JSON string, sent in the request body. Header peice indicates to the server request contains JSON so that the server can parse it correctly

      json_response = JSON.parse(response.body, symbolize_names: true)

      id = User.last.id

      expect(json_response[:data][:attributes][:email]).to eq("theguy@theguy.com")
      expect(json_response[:data][:id].to_i).to eq(id)
    end

    it "renders a JSON response with the new user" do
      valid_user = {
        email: "theguy@theguy.com",
        password: "notmypassword",
        password_confirmation: "notmypassword"
      }

      post "/api/v1/users", params: valid_user.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response[:data][:type]).to eq("user")

      expect(json_response[:data][:attributes][:email]).to eq("theguy@theguy.com")
      expect(json_response[:data][:attributes][:api_key]).to be_present
    end
  end

  describe "sad path" do
    it 'does not create a new user with invalid attributes' do
      valid_user = {
        email: "theguy@theguy.com",
        password: "notmypassword",
        password_confirmation: "notmypassword"
      }

      invalid_user = {
        email: "NOTtheguy@NOTtheguy.com",
        password: "nottheguyspassword",
        password_confirmation: "MAYBEtheguysPassword"
      }

      post "/api/v1/users", params: valid_user.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }

      # Attempt to create the user with invalid attributes
      post "/api/v1/users", params: invalid_user.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }

      expect(User.last.email).to eq("theguy@theguy.com")  
    end
  end
end