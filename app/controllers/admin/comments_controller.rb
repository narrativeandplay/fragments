class Admin::CommentsController < Admin::RootController
  def index
    @comments = Comment.page params[:page]
  end
end
