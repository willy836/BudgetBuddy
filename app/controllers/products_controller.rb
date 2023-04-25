class ProductsController < ApplicationController
  def new
    @category = Category.find(params[:category_id])
    @product = @category.products.build
  end

  def create
    @category = Category.find(params[:category_id])
    @product = @category.products.create(product_params.merge(user_id: current_user.id))

    if @product.persisted?
      redirect_to category_path(@category), notice: 'Successfully created a product'
    else
      flash.now[:alert] = 'Failed to create a product'
    end
  end

  def destroy
    @category = Category.find(params[:category_id])
    @product = @category.products.find(params[:id])

    if @product.destroy
      redirect_to category_path(@category), notice: 'Successfully deleted the product'
    else
      redirect_to category_path(@category), alert: 'Failed to delete the product'
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :amount)
  end
end
