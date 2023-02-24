class SendInactivityEmailWorker
  include Sidekiq::Worker

  sidekiq_options queue: :mailers, retry: 3

  def perform(*_args)
    inactive_user = User.joins(:user_donation_stats)
                        .where('user_donation_stats.last_donation_at >= ?', 1.week.ago)

    inactive_user.each do |user|
      send_email(user)
    end
  rescue StandardError => e
    Reporter.log(error: e, extra: { message: e.message })
  end

  def send_email(user)
    SendgridWebMailer.send_email(
      receiver: user.email,
      dynamic_template_data: {
        impact: user.user_donation_stats.last.impact,
      },
      template_name: 'email_reativacao',
      language: user.language
    ).deliver_now
  end
end
