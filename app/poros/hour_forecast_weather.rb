class HourForecastWeather
  attr_reader :time, :temperature, :condition_text, :condition_icon

  def initialize(data)
    @time = data[:time].split.last
    @temperature = data[:temp_f]
    @condition_text = data[:condition][:text]
    @condition_icon = data[:condition][:icon]
  end
end
