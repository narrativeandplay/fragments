class StoriesController < ApplicationController
  before_action :check_logged_in, only: [:create, :new]
  
  def index
    @stories = Story.page params[:page]
  end
  
  def new
    @story = Story.new
    @fragment = @story.fragments.new
  end
  
  def show
    @story = Story.find(params[:id])
    @fragment =  @story.fragments.new
    
    gon.fragments = add_author_name(@story.fragments.arrange_serializable(order: :created_at).first)
  end

  def create
    @story = current_user.stories.build(story_params)
    @fragment = @story.fragments.build(story_fragment_params.merge(author: current_user))
    
    if @story.save
      redirect_to @story
    else
      render 'new'
    end
  end
  
  
  def read
    @story = Story.find(params[:story_id])
    fragment = Fragment.find(params[:fragment_id])
    
    @fragments = fragment.path
  end
  
  private
  def story_params
    params.require(:story).permit(:title)
  end
  
  def story_fragment_params
    params.require(:story).permit(fragment: [:content, :parent])[:fragment]
  end

  def add_author_name(hash)
    hash[:author_name] = User.find(hash["author_id"]).username
    if hash["children"].count > 0
      hash["children"].each do |c|
        add_author_name(c)
      end
    end
    
    hash
  end
  
  def check_logged_in
    redirect_to new_user_session_url unless current_user
  end
end
