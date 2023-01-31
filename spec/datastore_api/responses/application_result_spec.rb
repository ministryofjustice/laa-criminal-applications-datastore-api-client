# frozen_string_literal: true

RSpec.describe DatastoreApi::Responses::ApplicationResult do
  subject { described_class.new(response) }

  describe 'FIELDS' do
    it {
      expect(
        described_class::FIELDS
      ).to eq(%w[
        id
        status
        reference
        schema_version
      ])
    }
  end

  describe '.new' do
    context 'delegation' do
      let(:response) do
        { 'id' => 'uuid', 'reference' => 12345, 'status' => 'submitted', 'schema_version' => 1.0 }
      end

      it 'assigns basic attributes, delegates the rest' do
        expect(subject.id).to eq('uuid')
        expect(subject.status).to eq('submitted')
        expect(subject.reference).to eq(12345)
        expect(subject.schema_version).to eq(1.0)

        expect(subject['client_details']).to be_nil
      end
    end
  end
end
