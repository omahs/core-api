# frozen_string_literal: true

module Users
  class CompleteTask < ApplicationCommand
    prepend SimpleCommand

    attr_reader :user, :task, :completed_task

    def initialize(user:, task:)
      @user           = user
      @task           = task
      @completed_task = user&.completed_tasks&.find_by(task_id: task&.id)
    end

    def call
      with_exception_handle do
        if user && task
          upsert_completed_task
        else
          handle_errors
        end
      end
    end

    private

    def upsert_completed_task
      if completed_task
        completed_task.update(completed_at:, completion_count:)
      else
        UserCompletedTask.create!(task:, user:, completed_at:, completion_count:)
      end
    end

    def completion_count
      (completed_task&.completion_count || 0) + 1
    end

    def completed_at
      @completed_at ||= Time.zone.now
    end

    def handle_errors
      errors.add(:message, 'Validation failed: Task must exist') if task.nil?
      errors.add(:message, 'Validation failed: User must exist') if user.nil?
    end
  end
end
