require "httpx"

class WeatherService
  BASE_URL = "https://api.open-meteo.com/v1/forecast".freeze

  def current_weather(latitude:, longitude:)
    params = {
      latitude: latitude,
      longitude: longitude,
      current_weather: true,
      timezone: "auto"
    }

    response = HTTPX.get(BASE_URL, params: params)

    if response.status != 200
      raise "HTTP error #{response.status}"
    end

    data = JSON.parse(response.to_s)
    current_weather = data.fetch("current_weather")

    {
      time: current_weather.fetch("time"),
      temperature: current_weather.fetch("temperature"),
      wind_speed: current_weather.fetch("windspeed"),
      latitude:  data.fetch("latitude"),
      longitude: data.fetch("longitude")
    }
  end
end
