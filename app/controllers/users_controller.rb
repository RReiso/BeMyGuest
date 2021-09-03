class UsersController < ApplicationController
before_action :require_user_logged_in, only: %i[show update]
before_action :require_correct_user, only: %i[show update]
before_action :require_admin_user,  only: %i[index destroy]

 def index
    @users = User.all
  end


  def show
     @user = User.find(params[:id])
      	@events = @user.events
  end

  #   def edit
  #   @user = User.find(params[:id])
  # end

  def update
if @user.update(user_params)
flash.now[:success] = "Password changed!"
else
 flash.now[:danger]='An error occured while changing password. Please try again.'
end
render 'show'
end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

private

    def user_params
      params
        .require(:user)
        .permit(:password, :password_confirmation)
    end

# def require_user_logged_in
# redirect_to login_url, warning: "Log in to continue." unless logged_in?
# end

# def require_correct_user
# @user = User.find_by(id: params[:id])
# redirect_to(current_user) unless current_user?(@user)
# end

 def require_admin_user
  if !logged_in?
    redirect_to root_path
  else
      redirect_to(current_user) unless current_user.admin?
  end
    end
end
