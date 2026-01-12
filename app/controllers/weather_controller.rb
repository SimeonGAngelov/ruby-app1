class WeatherController < ApplicationController
  def index
    @records = HourlyWeather.order(timestamp: :desc)
    @latitude = params[:latitude]
    @longitude = params[:longitude]
  end

  def create
    @latitude = params.require(:latitude)
    @longitude = params.require(:longitude)

    current_weather = WeatherService.new.current_weather(latitude: @latitude, longitude: @longitude)

    record = HourlyWeather.find_or_initialize_by(
      timestamp: Time.parse(current_weather[:time])
    )

    record.update!(
      latitude: current_weather[:latitude],
      longitude: current_weather[:longitude],
      temperature_2m: current_weather[:temperature],
      wind_speed_10m: current_weather[:wind_speed]
    )


    redirect_to weather_index_path
  rescue => e
    @records = HourlyWeather.order(timestamp: :desc).limit(200)
    @error_message = e.message
    render :index, status: :unprocessable_entity
  end
end
