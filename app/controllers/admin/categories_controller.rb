class Admin::CategoriesController < Admin::AdminController
  def create
    category = Category.new category_params
    if category.save
      flash[:success] = "Added!"
      redirect_to admin_products_path
    end
  end

  private
  def category_params
    params.require(:category).permit(:name,:cate_type)
  end
end
