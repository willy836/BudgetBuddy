class CategoriesController < ApplicationController
  before_action :authenticate_user!, :set_user, only: %i[index show new]

  def index
    @categories = @user.categories.includes(:products)
  end

  def show
    @category = @user.categories.find(params[:id])
    @products = @category.products.order(created_at: :desc)
  end

  def new
    @category = @user.categories.new
  end

  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      redirect_to categories_path, notice: 'Successfully created a category'
    else
      flash.now[:alert] = 'Failed to create a category'
      render :new
    end
  end

  def destroy
    @category = current_user.categories.find(params[:id])
    if @category.destroy
      redirect_to categories_path, notice: 'Category was deleted successfully'
    else
      redirect_to categories_path, alert: 'Failed to delete category'
    end
  end

  private

  def set_user
    @user = current_user
  end

  def category_params
    params.require(:category).permit(:name, :image)
  end
end
