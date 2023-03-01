# frozen_string_literal: true

module AuthorNews
  class UpdateNews < ApplicationCommand
    prepend SimpleCommand

    attr_reader :news_params

    def initialize(news_params)
      @news_params = news_params
    end

    def call
      with_exception_handle do
        news = News.find news_params[:id]
        news.update(update_news_params)

        news
      end
    end

    private

    def update_news_params
      news_params
    end
  end
end
