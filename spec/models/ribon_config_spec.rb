require 'rails_helper'

RSpec.describe RibonConfig, type: :model do
  it 'acts like a singleton' do
    create(:ribon_config)

    expect { create(:ribon_config) }.to raise_error(StandardError)
  end
end
