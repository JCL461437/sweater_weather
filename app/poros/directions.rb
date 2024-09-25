class Directions
  attr_reader :

  def initialize(json, origin, destination)
    @start_city = origin
    @end_city = destination
    @travel_time = json[:route][:formattedTime]

  end
end