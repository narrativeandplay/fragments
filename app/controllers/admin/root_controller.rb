class Admin::RootController < ApplicationController
  before_action :admin?

  layout 'admin/layouts/application'

  private
  def admin?
    redirect_to root_path unless user_signed_in? && current_user.admin?
  end
end