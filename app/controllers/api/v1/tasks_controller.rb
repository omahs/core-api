module Api
  module V1
    class TasksController < ApplicationController
      def index
        @tasks = Task.all

        render json: TaskBlueprint.render(@tasks)
      end

      def show
        @task = Task.find(params[:id])

        render json: TaskBlueprint.render(@task)
      end
    end
  end
end
