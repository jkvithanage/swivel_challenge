module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :set_category, only: %i[show update destroy]

      def index
        @categories = Category.all
        render json: @categories, include: :courses
      end

      def show
        render json: @category, include: :courses
      end

      def create
        @category = Category.new(category_params)
        if @category.save
          render json: @category.as_json(include: :courses), status: :created
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      end

      def update
        if @category.update(category_params)
          render json: @category.as_json(include: :courses)
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
        params.require(:category).permit(:name, :vertical_id, courses_attributes: %i[id name author state _destroy])
      end
    end
  end
end
