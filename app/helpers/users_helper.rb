module UsersHelper
  def require_user_logged_in
    redirect_to login_url, warning: 'Log in to continue.' unless logged_in?
  end

  def require_correct_user
    @user =
      if params[:controller] == 'users'
        User.find_by(id: params[:id])
      else
        User.find_by(id: params[:user_id])
      end

    redirect_to(current_user) unless current_user?(@user)
  end
end
