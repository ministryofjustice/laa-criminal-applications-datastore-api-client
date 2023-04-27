# frozen_string_literal: true

RSpec.describe DatastoreApi::Responses::HealthcheckResult do
  subject { described_class.new(response) }

  describe 'FIELDS' do
    it {
      expect(
        described_class::FIELDS
      ).to eq(%w[
        status
        error
      ])
    }
  end

  describe '.new' do
    context 'delegation' do
      let(:response) do
        { 'status' => 'ok', 'error' => nil, 'foobar' => 'test' }
      end

      it 'assigns basic attributes, delegates the rest' do
        expect(subject.status).to eq('ok')
        expect(subject.error).to be_nil

        expect(subject['foobar']).to eq('test')
      end
    end
  end

  describe '#error?' do
    let(:response) { { 'error' => error } }

    context 'when there is no error' do
      let(:error) { nil }

      it { expect(subject.error?).to be(false) }
    end

    context 'when there is an error' do
      let(:error) { 'boom!' }

      it { expect(subject.error?).to be(true) }
    end
  end

  describe '#success?' do
    let(:response) { { 'error' => error } }

    context 'when there is no error' do
      let(:error) { nil }

      it { expect(subject.success?).to be(true) }
    end

    context 'when there is an error' do
      let(:error) { 'boom!' }

      it { expect(subject.success?).to be(false) }
    end
  end
end
