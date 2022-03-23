class ApplicationController < ActionController::API
  before_action :set_language

  rescue_from CanCan::AccessDenied do |e|
    render json: ErrorBlueprint.render(e), status: :forbidden
  end

  protected

  def current_user
    @current_user ||= User.find_by(email: request.headers['Email'])
  end

  private

  def set_language
    I18n.locale = request.headers['Language']&.to_sym || :en
  end
end
