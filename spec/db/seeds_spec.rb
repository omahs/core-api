require 'rails_helper'

RSpec.describe 'Seed' do
  describe '#load_seed' do
    subject(:run_seed) { Rails.application.load_seed }

    it 'runs without raising error' do
      expect { run_seed }.not_to raise_error
    end

    it 'creates Ribon first configurations' do
      expect { run_seed }.to change(RibonConfig, :count).by(1)
    end

    it 'creates a NonProfit' do
      expect { run_seed }.to change(NonProfit, :count).by(1)
    end

    it 'creates an Integration' do
      expect { run_seed }.to change(Integration, :count).by(1)
    end

    it 'creates an Admin' do
      expect { run_seed }.to change(Admin, :count).by(1)
    end

    it 'creates a User' do
      expect { run_seed }.to change(User, :count).by(1)
    end

    it 'creates the Mumbai Chain' do
      expect { run_seed }.to change(Chain, :count).by(1)
    end
  end
end
