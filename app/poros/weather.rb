class Weather
  class Helpline
    attr_reader :location, :name, :region, 
                :lat, :lon, :timezone, 
                :localtime, :current, :last_updated, 
                :temperature, :condition, :text, 
                :icon, :humditiy, :feels_like, 
                :visibility, :uv,

  
    def initialize(current, forecasted)
      # Ensure data is a hash and not an array or other type
      data = current.is_a?(Hash) ? data : {}
  
      @location = data[:location]
      @name = data[:location][:name]
      @region = data[:location][:region]
      @lat = data[:location][:lat]
      @lon = data[:location][:lon]
      @timezone = data[:location][:tz_id]
      @localtime = data[:location][:localtime]

      @current = data[:current]
      @last_updated = data[:current][:last_updated]
      @temperature = data[:current][:temp_f]
      @condition = data[:current][:condition]
      @text = data[:current][:condition][:text]
      @icon = data[:current][:condition][:icon]
      @humidity = data[:current][:humidity]
      @feels_like = data[:current][:feelslike_f]
      @visibility = data[:current][:vis_miles]
      @uv = data[:current][:uv]
    end
  end
end