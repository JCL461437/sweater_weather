class LoginErrorSerializer 
  include JSONAPI::Serializer
  def self.error_response
    {
      errors: {
        status: '401',
        detail: "Invalid credentials, please re-enter and try again."
      }
    }
  end
end