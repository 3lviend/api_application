module ErrorsHandlers
  extend ActiveSupport::Concern

  included do
    # Handling error record not found
    rescue_from ActiveRecord::RecordNotFound do |exception|
      logger.error exception.message
      render json: {message: exception.message}, status: 404
    end

    # Handling argument error
    rescue_from ArgumentError do |exception|
      logger.error exception.message
      render json: {message: exception.message}, status: 422
    end

    # Handling no route match
    rescue_from ActionController::RoutingError do |exception|
     logger.error "Routing error occurred"

      render json: {message: "Page not found 404"}, status: 404
    end

    # Handling missing parameters
    rescue_from ActionController::ParameterMissing do |exception|
      logger.error exception.message
      render json: {message: exception.message.capitalize}, status: 422
    end

  end

end