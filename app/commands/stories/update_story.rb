# frozen_string_literal: true

module Stories
  class UpdateStory < ApplicationCommand
    prepend SimpleCommand

    attr_reader :story_params

    def initialize(story_params)
      @story_params = story_params
    end

    def call
      with_exception_handle do
        story = Story.find story_params[:id]
        story.update(update_story_params)

        story
      end
    end

    private

    def update_story_params
      story_params
    end
  end
end
