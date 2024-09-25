class MapQuestFacade
  def lat_long(location)
    json = MapQuestApiService.get_lat_long(location) # hitting methods in service
    lat = json[:results][0][:locations][0][:latLng][:lat]
    long = json[:results][0][:locations][0][:latLng][:lng]
    lat_long = "#{lat},#{long}"
  end

  def directions(origin, destination)
    json = MapQuestApiService.get_directions(origin, destination)
    Directions.new(json, origin, destination)
  end
end
