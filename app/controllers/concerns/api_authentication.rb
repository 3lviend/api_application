module ApiAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :check_secret_token
  end

  def check_secret_token
    secret_token = request.headers["secret-token"] || params[:secret_token]
    if secret_token.eql?(Rails.application.secrets.secret_token)
      return true
    else
      render json: {message: 'Unauthorized, Invalid secret token'}, status: 401 and return
    end
  end
end