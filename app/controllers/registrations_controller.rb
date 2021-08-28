class RegistrationsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      redirect_to root_url, info: "Account activation email was sent to  #{@user.email}.
      Please check your email to activate your account."
      #  log_in(@user)
      # redirect_to @user, success: "Welcome, #{@user.name}!!"
    else
      render 'new'
    end
  end

  private

    def user_params
      params
        .require(:user)
        .permit(:name, :email, :password, :password_confirmation, :terms_and_conditions)
    end
end
 