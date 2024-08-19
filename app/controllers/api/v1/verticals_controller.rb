class Api::V1::VerticalsController < ApplicationController
  before_action :set_vertical, only: %i[show update destroy]

  def index
    verticals = Vertical.includes(:categories).page(params[:page]).per(10)
    render json: verticals, meta: { total: verticals.total_count, total_pages: verticals.total_pages, current_page: verticals.current_page }
  end

  def search
    results = SearchService.new(Vertical, %i[name], params[:query], params[:sort], params[:page], 10).call
    render json: results, meta: { total: results.total_count, total_pages: results.total_pages, current_page: results.current_page }
  end

  def show
    render json: { data: @vertical }
  end

  def create
    vertical = Vertical.new(vertical_params)

    if vertical.save
      render json: vertical, status: :created
    else
      render json: vertical.errors, status: :unprocessable_entity
    end
  end

  def update
    if @vertical.update(vertical_params)
      render json: @vertical
    else
      render json: @vertical.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @vertical.destroy
    head :no_content
  end

  private

  def set_vertical
    @vertical = Vertical.find(params[:id])
  end

  def vertical_params
    params.require(:vertical).permit(:name, categories_attributes: [:id, :name, :state, :_destroy])
  end
end
