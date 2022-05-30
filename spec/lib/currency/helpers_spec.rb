require 'rails_helper'

RSpec.describe Currency::Helpers do
  before do
    test_class = Class.new do
      extend Currency::Helpers
    end
    stub_const('TestClass', test_class)
    allow(Money::Currency).to receive(:stringified_keys).and_return(%w[usd brl])
  end

  describe '#convert_froom_x_to_y' do
    context 'when the class is extended' do
      it 'defines the correct methods' do
        expect(TestClass).to respond_to('convert_from_brl_to_usd')
        expect(TestClass).to respond_to('convert_from_usd_to_brl')
      end
    end
  end
end
