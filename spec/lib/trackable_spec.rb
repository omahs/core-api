require 'rails_helper'

class TestClass
  include Trackable
end

RSpec.describe Trackable do
  describe '#track' do
    context 'when the trackable already has an utm' do
      let(:user) { create(:user) }

      it 'does not create a new utm' do
        test_instance = TestClass.new
        utm_params = { source: 'source', campaign: 'campaign', medium: 'medium' }
        user.create_utm!(utm_params)

        expect { test_instance.track(trackable: user, utm_params:) }.not_to change(Utm, :count)
      end
    end

    context 'when the trackable does not have an utm' do
      let(:user) { create(:user) }

      it 'does not create a new utm' do
        test_instance = TestClass.new
        utm_params = { source: 'source', campaign: 'campaign', medium: 'medium' }

        expect { test_instance.track(trackable: user, utm_params:) }.to change(Utm, :count).by(1)
      end
    end
  end
end
