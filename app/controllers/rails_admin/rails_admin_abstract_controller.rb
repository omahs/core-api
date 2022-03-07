module RailsAdmin
  class RailsAdminAbstractController < ApplicationController
    before_action :set_admin_locale

    private

    def set_admin_locale
      I18n.locale = params[:locale] if params[:locale]
    end
  end
end
