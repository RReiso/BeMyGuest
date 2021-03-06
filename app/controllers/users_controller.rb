class UsersController < ApplicationController
  before_action :require_user_logged_in, only: %i[show update]
  before_action :require_correct_user, only: %i[show update]
  before_action :require_admin_user, only: %i[index destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @events = @user.events
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Password changed!'
    else
      flash[:danger] =
        'An error occured while changing password. Please try again.'
    end
    redirect_to @user
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def require_admin_user
    if !logged_in?
      redirect_to root_path
    else
      redirect_to(current_user) unless current_user.admin?
    end
  end
end
