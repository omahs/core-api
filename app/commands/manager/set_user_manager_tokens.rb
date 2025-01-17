# frozen_string_literal: true

module Manager
  class SetUserManagerTokens < ApplicationCommand
    prepend SimpleCommand

    attr_reader :id_token

    def initialize(id_token:)
      @id_token = id_token
    end

    def call
      with_exception_handle do
        response = Request::ApiRequest.get(google_api_url)
        @user_manager = UserManager.create_user_for_google(response)
        tokens = @user_manager.create_new_auth_token
        @user_manager.save

        tokens
      end
    end

    private

    def google_api_url
      "https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{id_token}"
    end
  end
end
