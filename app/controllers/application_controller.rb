class ApplicationController < ActionController::API
  include ActionController::Serialization
  # handle API authentication secret token
  include ApiAuthentication
  # handle errors module
  include ErrorsHandlers

  # handle errors routing not found
  def error_404
    raise ActionController::RoutingError.new(params[:path])
  end
end

