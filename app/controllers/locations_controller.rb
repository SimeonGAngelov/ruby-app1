class LocationsController < ApplicationController
  before_action :require_login

  def index
    @locations = current_user.locations.order(latitude: :asc)
  end

  def create
    current_user.locations.create!(location_params)
    redirect_to locations_path
  rescue ActiveRecord::RecordInvalid => e
    @locations = current_user.locations.order(latitude: :asc)
    flash.now[:alert] = e.record.errors.full_messages.join(", ")
    render :index, status: :unprocessable_entity
  end

  def destroy
    @location = current_user.locations.find(params[:id])
    @location.destroy!

    respond_to do |format|
      format.turbo_stream   # -> destroy.turbo_stream.erb
      format.html { redirect_to weather_index_path, notice: "Location deleted." }
    end
  end

  private

  def location_params
    params.require(:location).permit(:latitude, :longitude)
  end
end
