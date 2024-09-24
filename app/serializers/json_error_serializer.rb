class JsonErrorSerializer 
  include JSONAPI::Serializer
  def self.bad_user_input
    {
      errors: [
        {
          status: '422',
          detail: "Those values cannot create a valid account, try again."
        }
      ]
    }
  end
end