class MapQuestApiService

  BASE_URL = "https://www.mapquestapi.com"

  def self.conn 
    Faraday.new(url: BASE_URL) do |faraday|
      faraday.params['key'] = Rails.application.credentials.map_quest[:key]
      faraday.adapter Faraday.default_adapter
    end
  end

  def self.get_lat_long(location)
    connection = Faraday.new(url: BASE_URL)

    response = connection.get("geocoding/v1/address?key=#{Rails.application.credentials.map_quest[:key]}&location=#{location}")
    JSON.parse(response.body, symbolize_names: true)
  end
end