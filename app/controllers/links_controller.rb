class LinksController < ApplicationController
	before_action :validate_user!, only: [:new, :create]
	def index
		@links = Link.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
		end
	def new
		if :validate_user!
		@link = Link.new
	else
		flash[:error] = "Please login to share a link."
	end
	end
	def create
		@link = current_user.links.create(params.require(:link).permit!)
		if @link.save
			redirect_to root_url
		else
			render :new
		end
	end
	def show
		@link = Link.find(params[:id])
	end
	def upvote
    @link = Link.find(params[:id])
    @link.liked_by current_user
    redirect_to :back
end	


end
