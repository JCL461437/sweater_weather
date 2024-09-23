class ParametersErrorSerializer 
  include JSONAPI::Serializer
    def self.location_error_json
      {
        errors: [
          {
            status: '422',
            detail: "No location was provided, try again with a location"
          }
        ]
      }
      end
  end
end