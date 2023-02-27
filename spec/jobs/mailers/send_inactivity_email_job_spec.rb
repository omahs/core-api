require 'rails_helper'

RSpec.describe Mailers::SendOneWeekInactivityEmailJob, type: :job do
  describe '#perform' do
    subject(:perform_job) { described_class.perform_now }

    let!(:user) { create(:user) }
    let!(:donation) { create(:donation, user:, created_at: 1.week.ago + 1.hour) }
    let!(:user_donation_stats) { create(:user_donation_stats, user:, last_donation_at: 1.week.ago + 1.hour) }

    include_context('when mocking a request') { let(:cassette_name) { 'sendgrid_email_api' } }

    before do
      allow(SendgridWebMailer).to receive(:send_email)
      perform_job
    end

    it 'calls the send_email method' do
      expect(SendgridWebMailer).to have_received(:send_email).with(
        receiver: user.email,
        dynamic_template_data: { 'lastWeekImpact': user.donations.last.impact },
        template_name: 'one_week_inactivity_template_id',
        language: user.language
      )
    end
  end
end
