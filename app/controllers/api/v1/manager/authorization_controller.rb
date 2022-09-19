module Api
  module V1
    module Manager
      class AuthorizationController < ApplicationController
        def google_authorization
          command = ::Manager::SetUserManagerTokens.call(id_token: params[:data]['id_token'])

          if command.success?
            create_headers(command.result)

            render json: { message: I18n.t('manager.login_success') }, status: :created
          else
            render_errors(command.errors)
          end
        end

        private

        def create_headers(tokens)
          headers['access-token'] = (tokens['access-token']).to_s
          headers['client'] = (tokens['client']).to_s
          headers['expiry'] = (tokens['expiry']).to_s
          headers['uid'] = (tokens['uid']).to_s
          headers['token-type'] = (tokens['token-type']).to_s
        end
      end
    end
  end
end
