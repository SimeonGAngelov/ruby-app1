class SessionsController < ApplicationController
  def new
  end

  def create
    name = params[:name].to_s.strip
    password = params[:password].to_s

    user = User.find_by(name: name)

    if user&.authenticate(password)
      reset_session
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in."
    else
      flash.now[:alert] = "Invalid name or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to new_sessions_path, notice: "Logged out."
  end
end
