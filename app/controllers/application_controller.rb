class ApplicationController < ActionController::Base
  # ここ何やってる？
  protect_from_forgery with: :null_session
  # なにこれ
  class AuthenticationError < StandardError; end
  
  # 例外処理
  rescue_from ActiveRecord::RecordInvalid, with: :render_422
  rescue_from AuthenticationError, with: :not_authenticated

  def authenticate
    raise AuthenticationError unless current_user
  end

  def current_user
    @current_user ||= Jwt::UserAuthenticator.call(request.headers)
  end

  private

    def render_422(exception)
      render json: { error: { messages: exception.record.errors.full_messages } }, status: :unprocessable_entity
      # unprocessable_enittyは422のエラー
    end

    def not_authenticated
      render json: { error: { messages: ['ログインしてください'] } }, stauts: :unauthorized
      # unauthorizedは401のエラー
    end

end
