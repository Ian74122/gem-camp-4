class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Category create successfully'
      redirect_to categories_path
    else
      flash[:alert] = 'Category create failed'
      render :new, status: :unprocessable_entity
    end
  end

  def edit

  end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Category update successfully'
      redirect_to categories_path
    else
      flash[:alert] = 'Category update failed'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = 'Delete category successfully'
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
