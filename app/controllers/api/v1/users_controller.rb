module Api
  module V1
    class UsersController < ApplicationController
      def search
        @user = User.find_by(email: params[:email])

        if @user
          render json: UserBlueprint.render(@user, view: :extended)
        else
          render json: { error: 'user not found' }, status: :not_found
        end
      end

      def create
        @user = User.new(user_params)

        if @user.save
          render json: UserBlueprint.render(@user), status: :created
        else
          head :unprocessable_entity
        end
      end

      def can_donate
        @integration = Integration.find_by_id_or_unique_address params[:integration_id]

        if current_user
          render json: { can_donate: current_user.can_donate?(@integration) }
        else
          render json: { can_donate: true }
        end
      end

      def complete_task
        @task = Task.find(params[:task_id])
        @user = User.find(params[:user_id])

        if @user && @task
          ::Users::CompleteTask.call(user: @user, task: @task)
          render json: UserBlueprint.render(@user, view: :extended), status: :ok
        else
          render json: { error: 'user or task not found' }, status: :not_found
        end
      end

      private

      def user_params
        params.permit(:email, :language)
      end
    end
  end
end
