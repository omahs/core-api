module Api
  module V1
    class StoriesController < ApplicationController
      def index
        @stories = Story.where(status: :active)

        render json: StoryBlueprint.render(@stories, view: :minimal)
      end

      def create
        command = Stories::CreateStory.call(story_params)
        if command.success?
          render json: StoryBlueprint.render(command.result, view: :minimal), status: :created
        else
          render_errors(command.errors)
        end
      end

      def show
        @story = Story.find_by fetch_story_query

        render json: StoryBlueprint.render(@story, view: :minimal)
      end

      def update
        command = Stories::UpdateStory.call(story_params)
        if command.success?
          render json: StoryBlueprint.render(command.result), status: :ok
        else
          render_errors(command.errors)
        end
      end

      private

      def story_params
        params.permit(:title, :description, :non_profit_id, :position, :active, :image)
      end

      def fetch_story_query
        uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/

        return { unique_address: story_params[:id] } if uuid_regex.match?(story_params[:id])

        { id: story_params[:id] }
      end
    end
  end
end
