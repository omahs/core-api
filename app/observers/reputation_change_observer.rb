class ReputationChangeObserver
  def update(changed_data)
    badge_id = changed_data[:merit_object].badge_id
    user_id = changed_data[:sash_id]
    granted_at = changed_data[:granted_at]

    Notifications::NotifyReputationChangeJob.perform_later(
      user_id:, badge_id:, granted_at:
    )
  rescue StandardError
    nil
  end
end