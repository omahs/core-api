module Api
    module V1
      module Users
        class TasksStatisticsController < ApplicationController
          def update_streak
            service = UserStreakTasks.new(user)

            if service.should_reset_streak? 
            service.reset_streak
            end
          end
  
          def streak
            return unless current_user
            tasks_statistics = current_user.user_tasks_statistic
            
            render json: { streak: tasks_statistics.streak }
          end

          private
        end
      end
    end
end
