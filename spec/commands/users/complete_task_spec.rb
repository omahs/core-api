# frozen_string_literal: true

require 'rails_helper'

describe Users::CompleteTask do
  describe '.call' do
    subject(:command) do
      described_class.call(user:, task:)
    end

    before do
      travel_to Time.zone.local(2022)
    end

    context 'when user and task are valid' do
      let(:user) { create(:user) }
      let(:task) { create(:task) }

      it 'creates an UserCompletedTask' do
        expect { command }.to change(UserCompletedTask, :count).by(1)
      end

      it 'creates an UserCompletedTask with correct attributes' do
        command

        expect(UserCompletedTask.last).to have_attributes(
          task:, user:, completed_at: Time.zone.now, completion_count: 1
        )
      end
    end

    context 'when task is invalid' do
      let(:user) { create(:user) }
      let(:task) { nil }

      it 'does not create an UserCompletedTask' do
        expect { command }.not_to change(UserCompletedTask, :count)
      end

      it 'returns an error' do
        expect(command.errors).to include(message: ['Validation failed: Task must exist'])
      end
    end

    context 'when user is invalid' do
      let(:user) { nil }
      let(:task) { create(:task) }

      it 'does not create an UserCompletedTask' do
        expect { command }.not_to change(UserCompletedTask, :count)
      end

      it 'returns an error' do
        expect(command.errors).to include(message: ['Validation failed: User must exist'])
      end
    end

    context 'when user already completed the task' do
      let(:user) { create(:user) }
      let(:task) { create(:task) }

      before do
        create(:user_completed_task, user:, task:, completed_at: 1.day.ago)
      end

      it 'does not create an UserCompletedTask' do
        expect { command }.not_to change(UserCompletedTask, :count)
      end

      it 'updates the UserCompletedTask with correct attributes' do
        command

        expect(UserCompletedTask.last).to have_attributes(
          task:, user:, completed_at: Time.zone.now, completion_count: 2
        )
      end
    end
  end
end
