class SessionsController < ApplicationController
  def create
  	user = User.find_by_username(params[:sessions][:user_name])

  	if user && user.authenticate(params[:sessions][:password])
  		session[:user_id] = user.id
  		redirect_to root_url
  	else
  		flash.now[:error] = "Username/Password doesn't match! Try again."
  		render :new
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_url
end
end