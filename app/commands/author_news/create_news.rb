# frozen_string_literal: true

module AuthorNews
  class CreateNews < ApplicationCommand
    prepend SimpleCommand

    attr_reader :news_params

    def initialize(news_params)
      @news_params = news_params
    end

    def call
      with_exception_handle do
        news = News.create!(news_params)

        news
      end
    end
  end
end
