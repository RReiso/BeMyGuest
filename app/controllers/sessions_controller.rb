class SessionsController < ApplicationController
	def new; end

	def create
		@user = User.find_by(email: params[:session][:email].downcase)
		if @user&.authenticate(params[:session][:password])
			if @user.activated?
				# forwarding_url = session[:forwarding_url]
				reset_session
				params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
				log_in(@user)
				redirect_to @user
			else
				redirect_to root_url,
				            warning:
						'Your account has not yet been activated. Check your email for the activation link.'
			end
		else
			flash.now[:danger] = 'Invalid email and/or password'
			render template: 'home/index'
		end
	end

	def destroy
		log_out if logged_in?
		redirect_to root_url
	end
end
