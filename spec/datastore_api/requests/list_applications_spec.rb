# frozen_string_literal: true

RSpec.describe DatastoreApi::Requests::ListApplications do
  subject { described_class.new(**args) }

  let(:http_client) { instance_double(DatastoreApi::HttpClient, get: response) }

  let(:args) {
    { status: :submitted, limit: 10 }
  }

  let(:response) { { 'pagination' => { limit: 10 }, 'records' => [{}, {}] } }

  describe '.new' do
    let(:args) { { status: nil } }

    it 'raises an error if the status is nil' do
      expect {
        subject.call
      }.to raise_error(ArgumentError, '`status` cannot be nil')
    end
  end

  describe '#call' do
    before do
      allow(subject).to receive(:http_client).and_return(http_client)
    end

    it_behaves_like 'an API request'

    it 'wraps the response in a PaginatedCollection' do
      expect(subject.call).to be_a(DatastoreApi::Decorators::PaginatedCollection)
    end

    it 'returns applications' do
      expect(subject.call.size).to eq(2)
    end

    it 'returns the pagination metadata' do
      expect(subject.call.pagination).to eq({ limit: 10 })
    end

    context 'endpoint' do
      it 'gets the correct endpoint' do
        expect(http_client).to receive(:get).with('/applications', { status: :submitted, limit: 10 })
        subject.call
      end
    end
  end
end
