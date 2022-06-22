# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reporter do
  describe '.log' do
    context 'when in production' do
      before do
        allow(Rails.env).to receive(:production?).and_return(true)
        allow(Sentry).to receive(:capture_exception)
      end

      it 'calls the Sentry capture_exception' do
        error = { message: 'error' }
        described_class.log(error:)

        expect(Sentry).to have_received(:capture_exception).with(error, extra: {}, level: :error)
      end
    end

    context 'when not in production' do
      before do
        allow(Rails.env).to receive(:production?).and_return(false)
        allow(Sentry).to receive(:capture_exception)
      end

      it 'calls the Sentry capture_exception' do
        error = { message: 'error' }
        described_class.log(error:)

        expect(Sentry).not_to have_received(:capture_exception)
      end
    end
  end
end
