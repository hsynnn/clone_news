class CommentsController < ApplicationController
	before_action :validate_user!, only: [:create]
	def new
		@link = Link.find(params[:link_id])
		@comment = @link.comments.new
		@comment.user = current_user
	end
	def create
		@link = Link.find(params[:link_id])
		@comment = @link.comments.new(comment_params)
		@comment.user = current_user
		if @comment.save
			redirect_to new_link_comment_path
		else
			render :new
		end
	end
	
	private
	def comment_params
		params.require(:comment).permit!
	end
end
