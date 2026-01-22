class FetchWeatherJob < ApplicationJob
  queue_as :default

  def perform(location_id)
    location = Location.find(location_id)
    current = WeatherService.new.current_weather(
      latitude: location.latitude,
      longitude: location.longitude
    )

    ts = Time.parse(current.fetch(:time))

    record = HourlyWeather.find_or_initialize_by(location_id: location.id, timestamp: ts)
    record.temperature_2m = current.fetch(:temperature)
    record.wind_speed_10m = current.fetch(:wind_speed)
    record.save!
  end
end
