# frozen_string_literal: true

RSpec.describe DatastoreApi::Requests::GetApplication do
  subject { described_class.new(**args) }

  let(:http_client) { instance_double(DatastoreApi::HttpClient, get: {}) }

  let(:args) {
    { application_id: 'xyz-123' }
  }

  describe '.new' do
    let(:args) { { application_id: nil } }

    it 'raises an error if the application_id is nil' do
      expect {
        subject.call
      }.to raise_error(ArgumentError, '`application_id` cannot be nil')
    end
  end

  describe '#call' do
    before do
      allow(subject).to receive(:http_client).and_return(http_client)
    end

    it_behaves_like 'an API request'

    it 'wraps the response in an ApplicationResult' do
      expect(subject.call).to be_a(DatastoreApi::Responses::ApplicationResult)
    end

    context 'endpoint' do
      it 'gets the correct endpoint' do
        expect(http_client).to receive(:get).with('/applications/xyz-123')
        subject.call
      end
    end
  end
end
