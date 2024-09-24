require "rails_helper"

RSpec.describe 'User Creation Request for POST /api/v1/users endpoint' do
  describe "happy path" do
    it "can log a user in with valid email AND password" do

      user = User.create!( email: "theman@theman.com", password: "themanspassword", password_confirmation: "themanspassword")
      email_password = { email: 'theman@theman.com', password: 'themanspassword' }

      post "/api/v1/sessions", params: email_password.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
      json_response = JSON.parse(json_response, symbolize_names: true)

      expect(json_response).to have_http_status(:success)

      expect(json_response[:data]).to have_key(:attributes)
      expect(json_response[:data][:attributes]).to have_key(:email)
      expect(json_response[:data][:attributes][:email]).to eq(user.email)
      
      expect(json_response[:data][:attributes]).to have_key(:api_key)
      expect(json_response[:data][:attributes][:api_key]).to eq(user.api_key)

      expect(json_response[:data]).to have_key(:type)
      expect(json_response[:data][:type]).to eq('user')
    end
  end

  describe "sad path" do
    it 'will not log a user in with invalid email' do
      user = User.create!( email: "theman@theman.com", password: "themanspassword", password_confirmation: "themanspassword")
      invalid_email = { email: 'theman@theman.net', password: 'themanspassword' }

      post "/api/v1/sessions", params: invalid_email.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }

      json_response = JSON.parse(json_response, symbolize_names: true)

      expect(json_response).to have_http_status(401)
      expect(json_response[:errors][:status]).to eq.('401')
      expect(json_response[:errors][:detail]).to eq.('Invalid credentials, please re-enter and try again.')
    end

    it 'will not log a user in with invalid password' do
      user = User.create!( email: "theman@theman.com", password: "themanspassword", password_confirmation: "themanspassword")
      invalid_password = { email: 'theman@theman.com', password: 'theGUYSpassword' }

      post "/api/v1/sessions", params: invalid_password.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }

      json_response = JSON.parse(json_response, symbolize_names: true)

      expect(json_response).to have_http_status(401)
      expect(json_response[:errors][:status]).to eq.('401')
      expect(json_response[:errors][:detail]).to eq.('Invalid credentials, please re-enter and try again.')
    end
  end
end