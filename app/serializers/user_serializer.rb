class UserSerializer
  include JSONAPI::Serializer

  def self.user_information(user)
    {
      "data": {
        "type": "user",
        "id": "#{user.id}",
        "attributes": {
          "email:" user.email,
          "api_key:" user.api_key
        }
      }
    }
  end
end