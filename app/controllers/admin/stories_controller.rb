class Admin::StoriesController < Admin::RootController
  def index
    @stories = Story.page params[:page]
  end
end
