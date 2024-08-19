class Api::V1::CoursesController < ApplicationController
  before_action :set_course, only: %i[show update destroy]

  def index
    courses = Course.page(params[:page]).per(10)
    render json: courses, meta: { total: courses.total_count, total_pages: courses.total_pages, current_page: courses.current_page }
  end

  def search
    results = SearchService.new(Course, %i[name], params[:query], params[:sort], params[:page], 10).call
    render json: results, meta: { total: results.total_count, total_pages: results.total_pages, current_page: results.current_page }
  end

  def show
    render json: @course
  end

  def create
    course = Course.new(course_params)
    if course.save
      render json: course, status: :created
    else
      render json: course.errors, status: :unprocessable_entity
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
