class LoginErrorSerializer 
  include JSONAPI::Serializer
  {
    errors: [
      {
        status: '401',
        detail: "Invalid credentials, please re-enter and try again."
      }
    ]
  }
end