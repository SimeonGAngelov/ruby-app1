class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    redirect_to new_session_path, alert: "Please log in" unless logged_in?
  end

  def load_weather_dashboard_data
    @locations = current_user.locations.order(latitude: :asc)
    @current_by_location = {}
    @records_by_location = {}
    @error_message ||= nil

    @locations.each do |loc|
      current = WeatherService.new.current_weather(
        latitude: loc.latitude,
        longitude: loc.longitude
      )

      ts = Time.parse(current.fetch(:time))

      record = HourlyWeather.find_or_initialize_by(
        location_id: loc.id,
        timestamp: ts
      )
      record.temperature_2m = current.fetch(:temperature)
      record.wind_speed_10m = current.fetch(:wind_speed)
      record.save!

      @current_by_location[loc.id] = current
      @records_by_location[loc.id] =
        loc.hourly_weathers.order(timestamp: :desc).limit(50)
    end
  end
end
