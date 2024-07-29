class Api::V1::CoursesController < ApplicationController
  before_action :set_course, only: %i[show update destroy]

  def index
    @courses = Course.search('*', page: params[:page], per_page: 20).to_a
    render json: @courses
  end

  def search
    results = Course.search(params[:query], fields: %i[name author], operator: "or")
    render json: results
  end

  def show
    render json: @course
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      render json: @course, status: :created
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  def update
    if @course.update(course_params)
      render json: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy
    head :no_content
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :author, :state, :category_id)
  end
end
