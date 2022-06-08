# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RedisStore::Cache do
  before { allow(RibonCoreApi).to receive(:redis).and_return(MockRedis.new) }

  describe '.cache' do
    context 'when no expire time is passed' do
      before do
        described_class.cache(key: :foo) { 'test' }
      end

      it 'does not cache' do
        expect(described_class.cache(key: :foo) { 'fallback' }).to eq 'fallback'
      end
    end

    context 'when store value with expires time' do
      before do
        described_class.cache(key: :foo, expires_in: 1.day) { 'test' }
      end

      context 'when the data is cached' do
        it 'gets the cached data' do
          expect(described_class.cache(key: :foo, expires_in: 1.day)).to eq 'test'
        end
      end

      context 'when the data expired' do
        it 'gets the fallback block and caches' do
          allow(Time).to receive(:now).and_return(2.days.from_now)
          expect(described_class.cache(key: :foo, expires_in: 1.day) { 'testing' }).to eq 'testing'
          expect(described_class
                   .cache(key: :foo, expires_in: 1.day) { 'not reached fallback' }).to eq 'testing'
        end
      end
    end
  end
end
