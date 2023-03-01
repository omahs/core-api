module Api
  module V1
    class NewsController < ApplicationController
      def index
        @news = news_list.order(sortable).page(page).per(per)

        render json: NewsBlueprint.render(@news, total_items:, page:, total_pages:)
      end
    
      def show
        @news = News.find(params[:id])
    
        render json: NewsBlueprint.render(@news)
      end
    
      def create
        command = AuthorNews::CreateNews.call(news_params)
        if command.success?
          render json: NewsBlueprint.render(command.result), status: :created
        else
          render_errors(command.errors)
        end
      end
    
      def update
        command = AuthorNews::UpdateNews.call(news_params.merge(id: params[:id]))
        if command.success?
          render json: NewsBlueprint.render(command.result)
        else
          render_errors(command.errors)
        end
      end
    
      private

      def news_list
        return News if params[:show_hidden_news].present?

        News.where(visible: true)
      end
    
      def sortable
        @sortable ||= params[:sort].present? ? "#{params[:sort]} #{sort_direction}" : 'created_at desc'
      end
    
      def sort_direction
        %w[asc desc].include?(params[:sort_dir]) ? params[:sort_dir] : 'asc'
      end
    
      def total_pages
        @news.page(@page).total_pages
      end
    
      def total_items
        @total_items = @news.count
      end
    
      def page
        @page = params[:page] || 1
      end
    
      def per
        @per = params[:per] || 100
      end
    
      def news_params
        params.permit(:title, :published_at, :image, :visible, :author_id, :id)
      end
    end    
  end
end