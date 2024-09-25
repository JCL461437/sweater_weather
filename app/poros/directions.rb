class Directions
  attr_reader :start_city, :end_city, :travel_time

  def initialize(json, origin, destination)
    @start_city = origin
    @end_city = destination
    @travel_time = json[:route][:formattedTime]
  end
end