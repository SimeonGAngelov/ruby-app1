class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    require_login

    user = User.find(params[:id])

    unless user.id == current_user.id
      redirect_to root_path, alert: "Not allowed!"
      return
    end

    reset_session
    user.destroy!
    redirect_to new_user_path, notice: "Account deleted!"
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
