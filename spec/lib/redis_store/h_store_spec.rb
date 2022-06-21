# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RedisStore::HStore do
  before { allow(RibonCoreApi).to receive(:redis).and_return(MockRedis.new) }

  describe '.set' do
    context 'when store value' do
      it { expect(described_class.set(key: :foo, value: :bar)).to eq :bar }
    end

    context 'when store value with expires time' do
      before do
        described_class.set(key: :foo, value: 'bar', expires_in: 1.day)
      end

      it { expect(described_class.get(key: :foo)).to eq 'bar' }

      it {
        allow(Time).to receive(:now).and_return(2.days.from_now)
        expect(described_class.get(key: :foo)).to be_nil
      }
    end
  end

  describe '.get' do
    context 'when get value' do
      before { described_class.set(key: :foo, value: 'zaz') }

      it { expect(described_class.get(key: :foo)).to eq 'zaz' }
    end
  end

  describe '.del' do
    context 'when delete value' do
      before { described_class.set(key: :foo, value: :zaz) }

      it { expect(described_class.del(key: :foo)).to be 1 }
    end
  end
end
