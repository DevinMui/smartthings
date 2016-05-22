class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  #skip_before_action :verify_authenticity_token, if: :json_request?
  #helper_method :current_user, :logged_in
  protected
  # api requests
	def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_more
    authenticate_token_more || render_unauthorized
  end

  def authenticate_token_more
    authenticate_with_http_token do |token, options|
      @user = User.find_by(auth_token: token)
    end
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      User.find_by(auth_token: token)
    end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: 'Bad credentials', status: 401
  end

  private

  def json_request?
    request.format.json?
  end
end
