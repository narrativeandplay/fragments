class FragmentsController < ApplicationController
  respond_to :json, :js
  
  before_action :check_login, only: [:create, :update]
  before_action :ensure_fragment_author, only: [:update]
  
  def show
    @fragment = Fragment.find(params[:id])
    @story = @fragment.story
  end
  
  def create
    @story = Story.find(params[:story_id])
    parent_fragment = Fragment.find(fragment_params[:parent])
    @fragment = @story.fragments.build(content: fragment_params[:content],
                                       parent: parent_fragment,
                                       author: current_user,
                                       intensity: fragment_params[:intensity])
    
    if @fragment.save
      render js: "window.location = '#{story_url(@story)}'"
    end
  end
  
  def update
    @fragment = Fragment.find(params[:id])
    if @fragment.update_attributes(content: fragment_params[:content], intensity: fragment_params[:intensity])
      render js: "window.location = '#{story_url(@fragment.story)}'"
    end
  end
  
  private
  def fragment_params
    params.require(:fragment).permit(:content, :parent, :intensity)
  end
  
  def check_login
    render js: "window.location = '#{new_user_session_url}'" unless user_signed_in?
  end
  
  def ensure_fragment_author
    fragment = Fragment.find(params[:id])
    flash[:error] = "You may only edit a fragment that you have authored!" unless is_current_user?(fragment.author)
    render js: "window.location = '#{story_url(fragment.story)}'" unless is_current_user?(fragment.author)
  end
end
