# test donation blueprint

require 'rails_helper'

RSpec.describe DonationBlueprint do
  let(:donation) { create(:donation) }
  let(:donation_blueprint) { DonationBlueprint.render(donation) }

  it 'should render donation' do
    expect(donation_blueprint).to include(:value.to_s)
    expect(donation_blueprint).to include(:impact.to_s)
    expect(donation_blueprint).to include(:impact_value.to_s)
  end
end