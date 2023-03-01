# frozen_string_literal: true

require 'rails_helper'

describe AuthorNews::CreateNews do
  describe '.call' do
    subject(:command) { described_class.call(news_params) }

    context 'when create with the right params' do
      let(:news_params) do
        {
          title: 'New News',
          published_at: Time.now,
          visible: true,
          author_id: create(:author).id
        }
      end

      context 'when create and have success' do
        it 'creates a new news' do
          command
          expect(News.count).to eq(1)
        end
      end
    end
  end
end
