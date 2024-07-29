# frozen_string_literal: true
module Api
  module V1
    class VerticalsController < ApplicationController
      before_action :set_vertical, only: %i[show update destroy]

      def index
        @verticals = Vertical.all
        render json: @verticals, include: { categories: { include: :courses } }
      end

      def show
        render json: @vertical, include: { categories: { include: :courses } }
      end

      def create
        @vertical = Vertical.new(vertical_params)

        if @vertical.save
          render json: @vertical.as_json(include: { categories: { include: :courses } }), status: :created
        else
          render json: @vertical.errors, status: :unprocessable_entity
        end
      end

      def update
        if @vertical.update(vertical_params)
          render json: @vertical.as_json(include: { categories: { include: :courses } })
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
        params.require(:vertical).permit(:name,
                                         categories_attributes: [:id, :name, :state, :_destroy,
                                                                 { courses_attributes: %i[id name author state _destroy] }])
      end
    end
  end
end
