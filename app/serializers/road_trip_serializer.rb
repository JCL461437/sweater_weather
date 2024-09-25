class RoadTripSerializer
  include JSONAPI::Serializer
  def self.road_trip(road_trip, five_days_forecast)
    {
      "data": {
          "id": "null",
          "type": "road_trip",
          "attributes": {
              "start_city": road_trip.start_city,
              "end_city": road_trip.end_city,
              "travel_time": road_trip.travel_time,
              "weather_at_eta": {
                  "datetime": ,
                  "temperature": ,
                  "condition": 
              }
          }
      }
    }

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
end