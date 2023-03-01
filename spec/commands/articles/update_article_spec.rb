# frozen_string_literal: true

require 'rails_helper'

describe Articles::UpdateArticle do
  describe '.call' do
    subject(:command) { described_class.call(article_params) }

    context 'when update with the right params' do
      let(:article) { create(:article) }
      let(:article_params) do
        {
          id: article.id,
          title: 'New article',
          published_at: Time.now,
          visible: true,
          author_id: create(:author).id
        }
      end

      context 'when update and have success' do
        it 'updates a article' do
          command
          expect(Article.count).to eq(1)
          expect(Article.first.title).to eq('New article')
        end
      end
    end
  end
end
