class WeatherSerializer
  include JSONAPI::Serializer

  def self.all_weather(current, five_days, hours)
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
          },  
          daily_weather: five_days.map do |day|
            days_forecast(day)
          end,
          hourly_weather: hours.map do |hour|
            hour_forecast(hour)
          end,
        }
      }
    }
  end

  def self.days_forecast(five_days)
    {
      date: five_days.date,
      sunrise: five_days.sunrise,
      sunset: five_days.sunset,
      max_temp: five_days.max_temp,
      min_temp: five_days.min_temp,
      condition_text: five_days.condition_text,
      condition_icon: five_days.condition_icon
    }
  end

  def self.hour_forecast(hours)
    {
      time: hours.time,
      temperature: hours.temperature,
      condition_text: hours.condition_text,
      condition_icon: hours.condition_icon
    }
  end
end
