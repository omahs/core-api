# tests history blueprint

require 'rails_helper'

RSpec.describe HistoryBlueprint do
  let(:history) { create(:history) }
  let(:history_blueprint) { described_class.render(history) }
  let(:history_blueprint_donor_views) { described_class.render(history, view: :donors) }
  let(:history_blueprint_donation_views) { described_class.render(history, view: :donations) }

  it 'renders history' do
    expect(history_blueprint).to include(:total_donors.to_s)
    expect(history_blueprint).to include(:total_donations.to_s)
  end

  it 'renders history with donors view' do
    expect(history_blueprint_donor_views).not_to include(:total_donations.to_s)
  end

  it 'renders history with donations view' do
    expect(history_blueprint_donation_views).not_to include(:total_donors.to_s)
  end
end
