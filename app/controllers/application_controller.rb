class ApplicationController < ActionController::API
  before_action :set_language

  private

  def set_language
    I18n.locale = request.headers['Language']&.to_sym || :en
  end
end
