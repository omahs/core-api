require 'rails_helper'

RSpec.describe Mailers::SendOneWeekInactivityEmailJob, type: :job do
  describe '#perform' do
    subject(:perform_job) { described_class.perform_now }

    let!(:user6daysago) { create(:user) }
    let!(:user1week) { create(:user) }
    let!(:user8daysago) { create(:user) }

    include_context('when mocking a request') { let(:cassette_name) { 'sendgrid_email_api' } }

    before do
      # user that donated 6 days ago
      create(:donation, user: user6daysago, created_at: 6.days.ago)
      create(:user_donation_stats, user: user6daysago, last_donation_at: 6.days.ago)
      # user that has donated one week ago
      create(:donation, user: user1week, created_at: 1.week.ago)
      create(:user_donation_stats, user: user1week, last_donation_at: 1.week.ago)
      # user that donated 8 days ago
      create(:donation, user: user8daysago, created_at: 8.days.ago)
      create(:user_donation_stats, user: user8daysago, last_donation_at: 8.days.ago)

      allow(SendgridWebMailer).to receive(:send_email)
      perform_job
    end

    describe 'when user donated last week' do
      it 'calls the send_email method' do
        expect(SendgridWebMailer).to have_received(:send_email).with(
          receiver: user1week.email,
          dynamic_template_data: { lastWeekImpact: user1week.donations.last.impact },
          template_name: 'one_week_inactivity_template_id',
          language: user1week.language
        )
      end
    end

    describe 'when user donated 6 days ago' do
      it 'does not call the send_email method' do
        expect(SendgridWebMailer).not_to have_received(:send_email).with(
          receiver: user6daysago.email,
          dynamic_template_data: { lastWeekImpact: user6daysago.donations.last.impact },
          template_name: 'one_week_inactivity_template_id',
          language: user6daysago.language
        )
      end
    end

    describe 'when user donated 8 days ago' do
      it 'does not call the send_email method' do
        expect(SendgridWebMailer).not_to have_received(:send_email).with(
          receiver: user8daysago.email,
          dynamic_template_data: { lastWeekImpact: user8daysago.donations.last.impact },
          template_name: 'one_week_inactivity_template_id',
          language: user8daysago.language
        )
      end
    end
  end
end
