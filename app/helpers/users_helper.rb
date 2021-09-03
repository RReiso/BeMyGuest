module UsersHelper
def require_user_logged_in
redirect_to login_url, warning: "Log in to continue." unless logged_in?
end

def require_correct_user
@user = User.find_by(id: params[:id])
redirect_to(current_user) unless current_user?(@user)
end
  
end
