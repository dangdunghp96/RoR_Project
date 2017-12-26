class Admin::ProductsController < Admin::AdminController
  def index
    @products = Product.all.paginate(:page => params[:page], :per_page => 10)
  end

  def create
  end

  def update
  end

  def destroy
  end
end
