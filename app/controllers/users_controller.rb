class UsersController < ApplicationController
before_action :select_user, only: [:show, :edit, :update, :destroy]
before_action :validate_permission!, only: [:edit, :update, :destroy]
around_filter :catch_not_found, only: [:destroy]
	def new
		@user = User.new
	end
	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to new_session_path
		else
			render :new
		end
	end
	def show
	end
	def edit
	end
	def update
		update_params = user_params
		if update_params.has_key?(:password)
		   update_params.delete([:password, :password_confirmation])
		end
		if @user.update(update_params)
			redirect_to root_url
		else
			render :edit
		end
	end
	def destroy
		session[:user_id] = nil
		@user.destroy
		redirect_to root_url
		end
		private
		def user_params
			params.require(:user).permit!
		end
		def select_user
			@user = User.find_by_username(params[:id])
			rescue ActiveRecord::RecordNotFound
  redirect_to(root_url, :notice => 'Record not found')
		end

		def validate_permission!
	    unless current_user == @user
		redirect_to root_url, alert: 'Nope!'
	end
end
def catch_not_found
yield
rescue ActiveRecord::RecordNotFound
  redirect_to root_url, :flash => { :error => "Record not found." }
end

end
