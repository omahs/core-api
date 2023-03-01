# frozen_string_literal: true

require 'rails_helper'

describe AuthorNews::UpdateNews do
  describe '.call' do
    subject(:command) { described_class.call(news_params) }

    context 'when update with the right params' do
      let(:news) { create(:news) }
      let(:news_params) do
        {
          id: news.id,
          title: 'New News',
          published_at: Time.now,
          visible: true,
          author_id: create(:author).id
        }
      end

      context 'when update and have success' do
        it 'updates a news' do
          command
          expect(News.count).to eq(1)
          expect(News.first.title).to eq('New News')
        end
      end
    end
  end
end
