class SessionsController < ApplicationController
  def new
  	if current_user
  		redirect_to root_url, notice: 'Please Logout First!!!'
  	end
  end

  def create  	
	  	user = User.find_by_email(params[:email])
	  	if user && user.authenticate(params[:password])
	  		session[:user_id] = user.id
	  		redirect_to root_url, notice: 'Successfully logged in!'
	  	else
	  		redirect_to login_path, notice: 'Invalid User Id / Password!!'
	  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_url, notice: 'Successfully logged out!'
  end
end