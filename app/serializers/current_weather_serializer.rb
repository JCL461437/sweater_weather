class CurrentWeatherSerializer
  include JSONAPI::Serializer

  def self.all_weather(current)
    {
      data: {
        id: nil,
        type: "forecast",
        attributes: {
          current_weather: {
            last_updated: current.last_updated,
            temperature: current.temperature,
            feels_like: current.feels_like,
            humidity: current.humidity,
            uv: current.uv,
            visibility: current.visibility,
            condition_text: current.text,
            condition_icon: current.icon
          }
        }
      }
    }
  end
end