class Api::V1::VerticalsController < ApplicationController
  before_action :set_vertical, only: %i[show update destroy]

  def index
    verticals = Vertical.includes(:categories)
    render json: verticals, meta: { total: courses.count }
  end

  def search
    results = if params[:query].present?
                SearchService.new(Vertical, params[:query], params[:sort], %i[name]).call
              else
                Course.search('*')
              end

    render json: results, meta: { total: results.count }
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
