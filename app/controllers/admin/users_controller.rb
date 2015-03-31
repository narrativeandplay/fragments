class Admin::UsersController < Admin::RootController
  def index
    @users = User.page params[:page]
  end

  def show
  end

  def new
  end

  def edit
  end
end
