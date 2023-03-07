# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Formatters::Date do
  describe '.in_words_for' do
    subject(:in_words_for) { described_class.in_words_for(date) }

    let(:date) { Time.zone.local(2017, 1, 1) }

    it 'returns a string' do
      expect(in_words_for).to be_a String
    end

    it 'returns the correct string' do
      expect(in_words_for).to eq '01 January'
    end

    context 'when the date is less than a week ago' do
      let(:date) { 1.day.ago }

      it 'returns the correct string' do
        expect(in_words_for).to eq '1 day ago'
      end
    end

    context 'when the date 1 minute ago' do
      let(:date) { 1.minute.ago }

      it 'returns the correct string' do
        expect(in_words_for).to eq '1 minute ago'
      end
    end
  end
end
