class Admin::ProfilesController < Admin::RootController
  def index
    @profiles = Profile.page params[:page]
  end
end
