class Api::V1::CoursesController < ApplicationController
  before_action :set_course, only: %i[show update destroy]

  def index
    courses = Course.all
    render json: courses, meta: { total: courses.count }
  end

  def search
    results = if params[:query].present?
                Course.search(
                  params[:query],
                  fields: %i[name author],
                  operator: "or",
                  order: { _score: :desc },
                  match: :word_middle
                )
              else
                Course.search('*')
              end

    render json: results, meta: { total: results.count }
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
