# frozen_string_literal: true

RSpec.describe DatastoreApi::Responses::ApplicationResult do
  subject { described_class.new(response) }

  describe 'FIELDS' do
    it {
      expect(
        described_class::FIELDS
      ).to eq(%w[
        id
        reference
        schema_version
      ])
    }
  end

  describe '.new' do
    context 'delegation' do
      let(:response) {
        { 'id' => 'uuid', 'reference' => 12345, 'status' => 'submitted' }
      }

      it 'assigns basic attributes, delegates the rest' do
        expect(subject.id).to eq('uuid')
        expect(subject.reference).to eq(12345)

        expect(subject['status']).to eq('submitted')
        expect(subject['client_details']).to be_nil
      end
    end
  end
end
