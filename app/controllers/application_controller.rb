class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
	  def current_user
	  	User.where(id: session[:user_id]).first
	  end
	  helper_method :current_user

	  def authorize
      	if current_user.nil?
        redirect_to login_url, alert: "Please Login First!"
      	end   
    end
    helper_method :authorize
end