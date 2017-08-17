class CommentsController < ApplicationController
  def create
  	user = User.find(session[:user_id])
  	comment = Comment.new(comment_params)
  	event = Event.find(params[:id])
  	comment.user = current_user
  	comment.event = event
  	
  	if (comment.valid?)
  		comment.save
  		session[:comment] = comment.id
  		redirect_to :back
  	else
  		flash[:errors] = comment.errors.full_messages
  		redirect_to :back
  	end
  end

  def show
  end

  private
  	def comment_params
  		params.require(:comment).permit(:content)
  	end
end
