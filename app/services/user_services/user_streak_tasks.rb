module UserServices
  class UserStreakTasks
    attr_reader :user

    def initialize(user)
      @user = user
      @statistics = user.user_tasks_statistics
    end

    def should_reset_streak?
      today = Date.today
      yesterday = today - 1.day
      last_completed_task_date = user.user_completed_tasks.order(last_completed_at: :desc).first&.last_completed_at

      return true if last_completed_task_date.nil?
      return true if last_completed_task_date < yesterday

      false
    end

    def reset_streak
      @statistics.update(streak: 0)
    end

    def increment_streak
      @statistics.increment!(:streak)
    end
  end
end
