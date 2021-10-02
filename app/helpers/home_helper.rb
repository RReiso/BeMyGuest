module HomeHelper
    def require_user_logged_out
      redirect_to(current_user) if logged_in?
  end
end
