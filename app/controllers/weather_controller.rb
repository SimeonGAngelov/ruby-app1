class WeatherController < ApplicationController
  before_action :require_login

  def index
    load_weather_dashboard_data
  end

  def create
    lat = params.require(:latitude)
    lon = params.require(:longitude)

    location = current_user.locations.find_or_create_by!(latitude: lat, longitude: lon)

    FetchWeatherJob.perform_later(location.id)

    redirect_to weather_index_path, notice: "Your job is running. Refresh in a moment to see new data."
  rescue => e
    redirect_to weather_index_path, alert: e.message
  end
end
