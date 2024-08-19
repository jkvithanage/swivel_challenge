module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    # Handle common exceptions globally
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActionController::ParameterMissing, with: :bad_request
    rescue_from ActionController::UnknownFormat, with: :not_acceptable
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
  end

  private

  def unprocessable_entity(exception)
    render json: { error: 'Unprocessable entity', message: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def route_not_found
    render json: { error: 'Route not found' }, status: :not_found
  end

  def not_acceptable
    render json: { error: 'Requested format is not supported' }, status: :not_acceptable
  end

  def record_not_found
    render json: { error: 'Record not found' }, status: :not_found
  end

  def bad_request
    render json: { error: 'Bad request' }, status: :bad_request
  end
end
