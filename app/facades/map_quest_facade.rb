class MapQuestFacade
  def lat_long(location)
    json = MapQuestApiService.get_lat_long(location) # hitting methods in service
    lat = json[:results][0][:locations][0][:latLng][:lat]
    long = json[:results][0][:locations][0][:latLng][:lng]
    lat_long = "#{lat},#{long}"
  end
end
