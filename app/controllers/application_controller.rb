class ApplicationController < ActionController::API
  include ExceptionHandler
  before_action :doorkeeper_authorize!

  # Overriding doorkeeper_unauthorized_render_options method to show meaningful errors
  def doorkeeper_unauthorized_render_options(error: nil)
    {
      json: {
        error: "Unauthorized",
        message: doorkeeper_error_description(error),
      }
    }
  end

  def invalid_route
    render json: { error: 'Route not found' }, status: :not_found
  end

  private

  def doorkeeper_error_description(error)
    case error.reason
    when :invalid_token
      "The access token provided is invalid."
    when :expired_token
      "The access token provided has expired."
    when :missing_token
      "No access token was provided in the request."
    else
      "Authentication failed."
    end
  end
end
