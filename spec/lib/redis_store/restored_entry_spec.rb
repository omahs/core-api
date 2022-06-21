# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RedisStore::RestoredEntry do
  describe '#expired?' do
    subject(:entry) { described_class.new(value: :foo, created_at: now, expires_in: 2.seconds) }

    let(:now) { Time.now.to_f }

    context 'when check value expired' do
      let(:entry) { described_class.new(value: :foo, created_at: now, expires_in: -1.second) }

      it { expect(entry.expired?).to be true }
    end

    context 'when check value is not expired' do
      it { expect(entry.expired?).to be false }
    end
  end
end
