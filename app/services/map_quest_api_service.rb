class MapQuestApiService

  BASE_URL = "https://www.mapquestapi.com"

  def self.connection 
    Faraday.new(url: BASE_URL) do |faraday|
      # faraday.params['key'] = Rails.application.credentials.map_quest[:key]
      faraday.headers['X-Api-Key'] = Rails.application.credentials.map_quest[:key]
      faraday.adapter Faraday.default_adapter
    end
  end

  def self.get_lat_long(location)
    response = connection.get("/geocoding/v1/address?key=#{Rails.application.credentials.map_quest[:key]}&location=#{location}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_directions(location, destination)
    response = connection.get("/directions/v2/route?key=#{Rails.application.credentials.map_quest[:key]}&from=#{location}&to=#{destination}")
    JSON.parse(response.body, symbolize_names: true)
  end
end