# frozen_string_literal: true

RSpec.describe DatastoreApi::Responses::ApplicationResult do
  subject { described_class.new(response) }

  describe 'FIELDS' do
    it {
      expect(
        described_class::FIELDS
      ).to eq(%w[
        id
        usn
        status
        schema_version
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

  describe 'DATE_FIELDS' do
    it {
      expect(
        described_class::DATE_FIELDS
      ).to eq(%w[
        created_at
        submitted_at
        date_stamp
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

    context 'parsing values' do
      context 'when value corresponds to a date field' do
        let(:response) {
          { 'id' => 12345, 'submitted_at' => '2022-11-11T15:36:09.000+00:00' }
        }

        it 'parses the date string' do
          expect(subject.submitted_at).to be_a(DateTime)
        end
      end
    end
  end
end
