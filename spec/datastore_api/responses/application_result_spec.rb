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
        version
        created_at
        submitted_at
        date_stamp
        provider_details
        client_details
        case_details
        interests_of_justice
      ])
    }
  end

  describe '.new' do
    context 'assign attributes, ignoring those not in the list' do
      let(:response) {
        { 'id' => 12345, 'status' => 'submitted' }
      }

      it 'assigns those we recognize and sets to nil those not present' do
        expect(subject.id).to eq(12345)
        expect(subject.status).to eq('submitted')
        expect(subject.client_details).to be_nil
      end
    end
  end
end
