class FragmentsController < ApplicationController
  respond_to :json, :js
  
  before_action :check_login, only: [:create]
  
  def show
    @fragment = Fragment.find(params[:id])
    
    respond_with @fragment.as_json.merge(author_name: @fragment.author.username).to_json
  end
  
  def create
    @story = Story.find(params[:story_id])
    parent_fragment = Fragment.find(fragment_params[:parent])
    @fragment = @story.fragments.build(content: fragment_params[:content], parent: parent_fragment, author: current_user)
    
    if @fragment.save
      render js: "window.location = '#{story_url(@story)}'"
    else
      render json: @fragment.errors.full_messages, status: :unprocessable_entity
    end
  end
  
  private
  def fragment_params
    params.require(:fragment).permit(:content, :parent)
  end
  
  def check_login
    render js: "window.location = '#{new_user_session_url}'" unless current_user
  end
end
