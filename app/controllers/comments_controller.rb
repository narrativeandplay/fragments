class CommentsController < ApplicationController
  respond_to :js, :json

  before_action :check_login

  def create
    @story = Story.find(params[:story_id])
    @comment = @story.comments.build(text: comment_params[:text], user: current_user)

    if @comment.save
      @comment = Comment.new(story: @story)
      @comments = @story.comments
    else
      render 'comments/new'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text)
  end

  def check_login
    render js: "window.location = '#{new_user_session_url}'" unless user_signed_in?
  end
end
