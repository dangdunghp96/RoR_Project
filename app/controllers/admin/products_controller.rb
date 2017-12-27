class Admin::ProductsController < Admin::AdminController

  def index
    @products = Product.all.paginate(:page => params[:page], :per_page => 10)
    @provider_list = Provider.all
  end

  def create
    product = Product.new product_params
    if product.save
      flash[:success] = "Added!"
      redirect_to admin_products_path
    end
  end

  def update
  end

  def destroy
    category = SubCategory.find_by product_id: params[:id]
    if category
      category.destroy
    end
    product = Product.find params[:id]
    product.destroy
    flash[:success] = "Deleted!"
    redirect_to admin_products_path
  end

  private
    def product_params
      params.require(:product).permit(:name,:description,:price,:quantity,:image,:image1,:image2,:image3,:provider_id)
    end
end
