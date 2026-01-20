class WeatherController < ApplicationController
  before_action :require_login

  def index
    load_weather_dashboard_data
  end

  def create
    lat = params.require(:latitude)
    lon = params.require(:longitude)

    current_user.locations.find_or_create_by!(latitude: lat, longitude: lon)

    load_weather_dashboard_data

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to weather_index_path }
    end
  rescue => e
    @error_message = e.message
    load_weather_dashboard_data
    respond_to do |format|
      format.turbo_stream { render :index, status: :unprocessable_entity }
      format.html { render :index, status: :unprocessable_entity }
    end
  end
end
