class UsersController < ApplicationController
before_action :require_user_loged_in, only: %i[show update]
before_action :require_correct_user, only: %i[show update]



  def show
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

private

    def user_params
      params
        .require(:user)
        .permit(:password, :password_confirmation)
    end

def require_user_loged_in
redirect_to login_url, warning: "Log in to continue." unless logged_in?
end

def require_correct_user
@user = User.find(params[:id])
redirect_to(root_url) unless current_user?(@user)
end

end
