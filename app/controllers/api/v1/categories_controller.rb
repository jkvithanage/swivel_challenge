class Api::V1::CategoriesController < ApplicationController
  before_action :set_category, only: %i[show update destroy]

  def index
    categories = Category.includes(:courses).page(params[:page]).per(10)
    render json: categories, meta: { total: categories.total_count, total_pages: categories.total_pages, current_page: categories.current_page }
  end

  def search
    results = SearchService.new(Category, %i[name], params[:query], params[:sort], params[:page], 10).call
    render json: results, meta: { total: results.total_count, total_pages: results.total_pages, current_page: results.current_page }
  end

  def show
    render json: @category
  end

  def create
    category = Category.new(category_params)
    if category.save
      render json: category, status: :created
    else
      render json: category.errors, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    head :no_content
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :vertical_id, :state, courses_attributes: %i[id name author state _destroy])
  end
end
