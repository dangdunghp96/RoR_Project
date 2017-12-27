class Admin::ProvidersController < Admin::AdminController
  def create
    provider = Provider.new provider_params
    if provider.save
      flash[:success] = "Added!"
      redirect_to admin_products_path
    end
  end

  private
  def provider_params
    params.require(:provider).permit(:name,:description)
  end
end
