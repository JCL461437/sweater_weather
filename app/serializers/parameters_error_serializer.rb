class ParametersErrorSerializer 
  def self.quantity_error_json
  {
    errors: [
      {
        status: '422',
        detail: "No quantity was provided, try again with a quantity"
      }
    ]
  }
  end

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