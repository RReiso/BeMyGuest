class AccountActivationsController < ApplicationController
  def edit
    @user = User.find_by(email: params[:email])
    if @user && !@user.activated? && @user.authenticated?(:activation, params[:id])
     @user.activate
      log_in(@user)
      flash[:success] = "Your account has been successfully activated!"
      redirect_to @user
    else
      redirect_to root_url, danger: "Error activating account. Invalid activation link."
    end
  end
end
