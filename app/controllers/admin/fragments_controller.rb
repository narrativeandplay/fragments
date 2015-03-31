class Admin::FragmentsController < Admin::RootController
  def index
    @fragments = Fragment.page params[:page]
  end

  def edit
    @fragment = Fragment.find params[:id]
  end

  def update
    @fragment = Fragment.find params[:id]

    puts fragment_params

    updated_fragment = fragment_params
    if @fragment.update_attributes fragment_params
      redirect_to admin_fragments_path
    else
      render 'edit'
    end
  end

  private
  def fragment_params
    params.require(:fragment).permit(:content, :created_at)
  end
end
