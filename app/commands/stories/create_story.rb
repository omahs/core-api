# frozen_string_literal: true

module Stories
  class CreateStory < ApplicationCommand
    prepend SimpleCommand
    include Web3

    attr_reader :story_params

    def initialize(story_params)
      @story_params = story_params
    end

    def call
      with_exception_handle do
        story = Story.create!(story_params)

        story
      end
    end
  end
end
