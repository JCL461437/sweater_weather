class FiveDaysForecastWeather
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :condition_text,
              :condition_icon

  def initialize(data)
    @date = data[:date]
    @sunrise = data[:astro][:sunrise]
    @sunset = data[:astro][:sunset]
    @max_temp = data[:day][:maxtemp_f]
    @min_temp = data[:day][:mintemp_f]
    @condition_text = data[:day][:condition][:text]
    @condition_icon = data[:day][:condition][:icon]
  end
end