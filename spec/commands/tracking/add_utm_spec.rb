describe Tracking::AddUtm do
  describe '.call' do
    let(:user) { create(:user) }
    let(:utm_source) { 'source' }
    let(:utm_medium) { 'medium' }
    let(:utm_campaign) { 'campaign' }

    context 'when send all parameters correctly' do
      it 'expects to create an new utm' do
        command = described_class.new(utm_source:, utm_medium:, utm_campaign:)
        expect { command.call(trackable: user) }.to change(Utm, :count).by(1)
      end
    end

    context 'when trackable already has a utm' do
      before do
        create(:utm, trackable: user)
      end

      it 'expects not to create a new utm' do
        command = described_class.new(utm_source:, utm_medium:, utm_campaign:)
        expect { command.call(trackable: user) }.not_to change(Utm, :count)
      end
    end

    context 'when does not send all parameters correctly' do
      let(:utm_source) { nil }
      let(:utm_medium) { nil }
      let(:utm_campaign) { nil }

      it 'expects not to craete a new utm' do
        command = described_class.new(utm_source:, utm_medium:, utm_campaign:)
        expect { command.call(trackable: user) }.not_to change(Utm, :count)
      end
    end

    context 'when an error happens' do
      let(:user) { create(:user) }

      before do
        allow(Utm).to receive(:create!).and_raise(StandardError)
      end

      it 'expects not to create an new utm' do
        command = described_class.new(utm_source:, utm_medium:, utm_campaign:)
        expect { command.call(trackable: nil) }.not_to change(Utm, :count)
      end
    end
  end
end
